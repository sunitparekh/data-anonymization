module DataAnon
  module Strategy
    module Field

      class SelectFromDatabase < SelectFromFile
        include Utils::Logging

        def initialize table_name, field_name, connection_spec
          DataAnon::Utils::SourceDatabase.establish_connection connection_spec
          source = Utils::SourceTable.create table_name, []
          @values = source.select(field_name).uniq.collect { |record| record[field_name]}
          logger.debug "For field strategy #{table_name}:#{field_name} using values #{@values} "

        end

      end


    end
  end
end