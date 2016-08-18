module DataAnon
  module Strategy
    module Field

      # Similar to SelectFromList with difference is the list of values are collected from the database table using distinct column query.
      #
      #    !!!ruby
      #    # values are collected using `select distinct state from customers` query
      #    anonymize('State').using FieldStrategy::SelectFromDatabase.new('customers','state')

      class SelectFromDatabase < SelectFromFile
        include Utils::Logging

        def initialize table_name, field_name, connection_spec
          DataAnon::Utils::SourceDatabase.establish_connection connection_spec
          source = Utils::SourceTable.create table_name, []
          @values = source.select(field_name).distinct.collect { |record| record[field_name]}
          logger.debug "For field strategy #{table_name}:#{field_name} using values #{@values} "

        end

      end


    end
  end
end