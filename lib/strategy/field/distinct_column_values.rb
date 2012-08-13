module DataAnon
  module Strategy
    module Field

      class DistinctColumnValues
        include Utils::Logging

        def initialize table_name, field_name
          source = Utils::SourceTable.create table_name
          @values = source.select(field_name).uniq.collect { |record| record[field_name]}
          logger.debug "For field strategy #{table_name}:#{field_name} using values #{@values} "

        end

        def anonymize field
          return @values[0] if @values.length == 1
          @values[DataAnon::Utils::RandomInt.generate(0,(@values.length - 1))]
        end

      end


    end
  end
end