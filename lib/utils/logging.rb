require 'active_record'
require 'logger'

module DataAnon
  module Utils
    module Logging

      def logger
        @@utils_logger ||= (self.logger = Logger.new(STDOUT) )
      end

      def logger= logger
        @@utils_logger = logger
        ActiveRecord::Base.logger = logger
        @@utils_logger
      end

    end
  end
end
