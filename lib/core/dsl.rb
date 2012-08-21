module DataAnon
  module Core
    module DSL
      include Utils::Logging

      def database(name, &block)
        logger.debug "Processing Database: #{name}"
        database = DataAnon::Core::Database.new(name)
        database.instance_eval &block
        database.anonymize
      end

    end
  end
end

include DataAnon::Core::DSL

