module DataAnon
  module Strategy
    module Field

      class SelectFromDatabase
        include Utils::Logging

        def initialize table_name, field_name, connection_spec
          DataAnon::Utils::SourceDatabase.establish_connection connection_spec
          source = Utils::SourceTable.create table_name, []
          @values = source.select(field_name).uniq.collect { |record| record[field_name]}
          logger.debug "For field strategy #{table_name}:#{field_name} using values #{@values} "

        end

        def anonymize field
          @values[DataAnon::Utils::RandomInt.generate(0,(@values.length - 1))]
        end

      end


    end
  end
end