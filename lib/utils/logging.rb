require 'active_record'
require 'logger'

module DataAnon
  module Utils
    module Logging

      LOGGER = Logger.new(STDOUT)
      PROGRESS_LOGGER = Logger.new(STDOUT)
      PROGRESS_LOGGER.formatter = proc { |severity, datetime, progname, msg| msg}

      def logger
        LOGGER
      end

      def progress_logger
        PROGRESS_LOGGER
      end
    end
  end
end