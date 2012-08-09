module DataAnon
  module Strategy
    class Base
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


    end
  end
end