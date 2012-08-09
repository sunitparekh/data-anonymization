module DataAnon
  module Core
    module DSL
      include Utils::Logging

      def database(name, &block)
        logger.debug "#{name} : Database"
        DataAnon::Core::Database.new(name).instance_eval &block
      end

    end
  end
end

include DataAnon::Core::DSL

