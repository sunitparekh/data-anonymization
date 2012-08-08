module DataAnon
  module Strategy
    class Whitelist
      include Utils::Logging

      def initialize name
        @name = name
        @fields = {}
      end

      def process_fields &block
        block.call self
        self
      end

      def primary_key field
        @primary_key = field
      end

      def whitelist *fields
        fields.each { |f| @fields[f.downcase] = DataAnon::Strategy::Field::Whitelist.new }
      end

      def fields
        @fields
      end

      def anonymize *fields
        fields.each { |f| @fields[f.downcase] = DataAnon::Strategy::Field::DefaultAnon.new }
        temp = self
        return Class.new do

          @temp_fields = fields
          @table_fields = temp.fields

          def self.using field_strategy
            @temp_fields.each { |f| @table_fields[f.downcase] = field_strategy }
          end

        end
      end


      def process
        source = Utils::SourceTable.create @name, @primary_key
        dest = Utils::DestinationTable.create @name, @primary_key
        logger.debug "Processing table #{@name} with fields strategy using #{@fields}"
        progress_logger.info "Table: #{@name} "
        index = 1
        source.all.each do |record|
          progress_logger.info "."
          dest_record_map = {}
          record.attributes.each do | field_name, field_value |
            field = DataAnon::Core::Field.new(field_name, field_value, index, record)
            field_strategy = @fields[field_name.downcase] || DataAnon::Strategy::Field::DefaultAnon.new
            dest_record_map[field_name] = field_strategy.anonymize(field)
          end
          dest_record = dest.new dest_record_map
          dest_record.save!
          index += 1
        end
        progress_logger.info " DONE\n"
      end
    end
  end
end
