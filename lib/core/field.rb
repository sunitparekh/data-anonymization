module DataAnon
  module Core

    class Field

      def initialize name, value, row_index, record
        @name = name
        @value = value
        @row_index = row_index
        @record = record
      end

      attr_accessor :name, :value, :row_index, :record

    end

  end
end