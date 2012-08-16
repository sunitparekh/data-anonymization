module DataAnon
  module Core
    module DSL
      include Utils::Logging

      def database(name, &block)
        logger.debug "Processing Database: #{name}"
        DataAnon::Core::Database.new(name).instance_eval &block
      end

    end
  end
end

include DataAnon::Core::DSL

