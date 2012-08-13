module DataAnon
  module Strategy
    class Base
      include Utils::Logging

      def initialize name, user_strategies
        @name = name
        @user_strategies = user_strategies
        @fields = {}
      end

      def process_fields &block
        self.instance_eval &block
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

      def anonymize *fields, &block
        if block.nil?
          fields.each { |f| @fields[f.downcase] = DataAnon::Strategy::Field::DefaultAnon.new(@user_strategies) }
          temp = self
          return Class.new do
            @temp_fields = fields
            @table_fields = temp.fields
            def self.using field_strategy
              @temp_fields.each { |f| @table_fields[f.downcase] = field_strategy }
            end
          end
        else
          fields.each { |f| @fields[f.downcase] = DataAnon::Strategy::Field::Anonymous.new(&block) }
        end
      end

      def dest_table
        @dest_table ||= Utils::DestinationTable.create @name, @primary_key
      end

      def source_table
        @source_table ||= Utils::SourceTable.create @name, @primary_key
      end

      def process
        logger.debug "Processing table #{@name} with fields strategies #{@fields}"
        progress_logger.info "Table: #{@name} (#{source_table.count} records) "
        index = 1
        source_table.find_each(:batch_size => 100) do |record|
          progress_logger.info "."
          process_record index, record
          index += 1
        end
        progress_logger.info " DONE\n"
      end

    end
  end
end