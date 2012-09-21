require 'powerbar'

module DataAnon
  module Utils

    class ParallelProgressBar < ProgressBar
      include Utils::Logging

      def initialize table_name, total
        @total = total
        @table_name = table_name
      end

      protected

      def show_progress index
        suffix = started(index) ? "STARTED" : (complete(index) ? "COMPLETE" : "")
        logger.info("%-30s [ %7d/%-7d ] %s" % [@table_name, index, @total, suffix])
      end

    end

  end
end