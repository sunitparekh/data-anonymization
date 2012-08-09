module DataAnon
  module Core
    module DSL
      include Utils::Logging

      def database(name, &block)
        logger.debug "#{name} : Database"
        yield block
      end

      def strategy strategy
        @strategy = strategy
      end

      def source_db connection_spec
        DataAnon::Utils::SourceDatabase.establish_connection connection_spec
      end

      def destination_db connection_spec
        DataAnon::Utils::DestinationDatabase.establish_connection connection_spec
      end

      def table (name, &block)
        @strategy.new(name).process_fields(&block).process
      end

    end
  end
end

include DataAnon::Core::DSL

