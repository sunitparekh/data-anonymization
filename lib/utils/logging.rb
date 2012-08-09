require 'active_record'
require 'logger'

module DataAnon
  module Utils
    module Logging

      def logger
        @@logger ||= (self.logger = Logger.new(STDOUT) )
      end

      def logger= logger
        @@logger = logger
        ActiveRecord::Base.logger = logger
        @@logger
      end

      def progress_logger
        @@progress_logger ||= (self.progress_logger = Logger.new(STDOUT) )
      end

      def progress_logger= logger
        logger.formatter = proc { |severity, datetime, progname, msg| msg }
        @@progress_logger = logger
      end

    end
  end
end