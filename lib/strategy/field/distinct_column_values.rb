module DataAnon
  module Strategy
    module Field

      class DistinctColumnValues
        include Utils::Logging

        def initialize table_name, field_name
          source = Utils::SourceTable.create table_name
          @values = source.select(field_name).uniq.collect { |record| record[field_name]}
          logger.debug "For field strategy #{table_name}:#{field_name} using values #{@values} "
          @number_util = DataAnon::Utils::NumberUtils.new
        end

        def anonymize field
          return @values[0] if @values.length == 1
          @values[@number_util.generate_random_int(0,(@values.length - 1))]
        end

      end


    end
  end
end