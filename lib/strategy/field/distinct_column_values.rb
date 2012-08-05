module DataAnon
  module Strategy
    module Field


      class DistinctColumnValues

        def initialize table_name, field_name
          source = Utils::SourceTable.create table_name
          @values = source.select(field_name).uniq.collect { |record| record[field_name]}
          p @values
        end

        def anonymize field
          return @values[0] if @values.length == 1
          @values[Random.new.rand 0...(@values.length - 1)]
        end

      end


    end
  end
end