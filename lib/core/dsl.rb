module DataAnon
  module Core
    module DSL
      include Utils::Logging

      def database(name, source, destination , &block)
        logger.debug "#{name} : Database"
        DataAnon::Utils::SourceDatabase.establish_connection source
        DataAnon::Utils::DestinationDatabase.establish_connection destination
        yield block
      end

      def table (name, &block)
        Table.new(name).fields(&block).process
      end

    end
  end
end

extend DataAnon::Core::DSL
Module.send(:include, DataAnon::Core::DSL)

