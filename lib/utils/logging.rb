require 'active_record'
require 'logger'

module DataAnon
  module Utils
    module Logging
      LOGGER = Logger.new(STDOUT)
      def logger
        LOGGER
      end
    end
  end
end