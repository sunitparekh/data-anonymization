module DataAnon
  module Core

    class Field

      def initialize name, value, row_number, ar_record, table_name = "unknown"
        @name = name
        @value = value
        @row_number = row_number
        @ar_record = ar_record
        @table_name = table_name
      end

      attr_accessor :name, :value, :row_number, :ar_record, :table_name

      alias :collection_name :table_name

    end

  end
end