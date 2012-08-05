require 'active_record'
require 'logger'

module DataAnon
  module Utils
    module Logging

      @@logger = Logger.new(STDOUT)
      @@progress_logger = Logger.new(STDOUT)
      @@progress_logger.formatter = proc { |severity, datetime, progname, msg| msg }

      def logger
        @@logger
      end

      def logger= logger
        @@logger = logger
      end

      def progress_logger
        @@progress_logger
      end

      def progress_logger= logger
        logger.formatter = proc { |severity, datetime, progname, msg| msg }
        @@progress_logger = logger
      end

    end
  end
end