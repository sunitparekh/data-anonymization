require 'logger'

module DataAnon
  module Utils
    module Logging
      def logger
        @logger ||= Logging.logger_for(self.class.name)
      end

      @loggers = {}

      class << self
        def logger_for(classname)
          @loggers[classname] ||= Logger.new(STDERR)
        end
      end
    end
  end
end