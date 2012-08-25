require 'powerbar'

module DataAnon
  module Utils

    class ProgressBar
      include Utils::Logging

      def initialize table_name, total
        @total = total
        @table_name = table_name
        @progress_bar = PowerBar.new if total > 0 && show_progress && !parallel?
      end

      def show_progress
        ENV['show_progress'] != 'false'
      end

      def parallel?
        ENV['parallel_execution'] == 'true'
      end

      def show index
        if started(index) || regular_interval(index) || complete(index)
          if @progress_bar
            msg = "Table: %-15s [ %6d/%-6d ]" % [ @table_name,index,@total]
            @progress_bar.show(:msg => msg, :done => index, :total => @total)
          elsif parallel?
            suffix = ""
            suffix = "STARTED" if started(index)
            suffix = "COMPLETE" if complete(index)
            logger.info("Table: %-15s [ %6d/%-6d ] %s" % [ @table_name,index,@total, suffix])
          end
        end
      end

      def complete index
        index == @total
      end

      def regular_interval index
        index % 1000 == 0
      end

      def started index
        index == 1
      end

      def close
        @progress_bar.close if @progress_bar
      end

    end

  end
end