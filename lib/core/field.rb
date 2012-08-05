module DataAnon
  module Core

    class Field

      def initialize name, value, row_number, ar_record
        @name = name
        @value = value
        @row_number = row_number
        @ar_record = ar_record
      end

      attr_accessor :name, :value, :row_number, :ar_record

    end

  end
end