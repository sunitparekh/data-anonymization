module DataAnon
  module Core

    class FieldsMissingStrategy
      include Utils::Logging

      def initialize table_name
        @table_name = table_name
        @fields_missing_strategy = []
      end

      def missing field_name
        return if @fields_missing_strategy.include? field_name
        @fields_missing_strategy << field_name
      end

      def fields_missing_strategy
        @fields_missing_strategy
      end

      def print
        @fields_missing_strategy.each do |field_name|
          logger.info("#{@table_name}.#{field_name}")
        end
      end

    end

  end
end