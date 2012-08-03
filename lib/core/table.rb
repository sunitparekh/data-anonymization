module DataAnon
  module Core
    class Table
      include Utils::Logging

      def initialize name
        @name = name
        @fields = {}
      end

      def fields &block
        block.call self
        self
      end

      def primary_key field
        @field = field
      end

      def whitelist *fields
        fields.each { |f| @fields[f.downcase] = DataAnon::Strategy::Whitelist }
      end

      def anonymize *fields
        fields.each { |f| @fields[f.downcase] = DataAnon::Strategy::Whitelist }
      end

      def process
        logger.debug "  #{@name} : Table"
        source = Utils::SourceTable.create @name, @primary_key
        dest = Utils::DestinationTable.create @name, @primary_key
        source.all.each do |record|
          dest_record_map = {}
          record.attributes.each do | field_name, field_value |
            dest_record_map[field_name] = @fields[field_name.downcase].new.process( field_name, field_value )
          end
          dest_record = dest.new dest_record_map
          dest_record.save!
        end
      end
    end
  end
end
