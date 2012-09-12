require 'powerbar'

module DataAnon
  module Utils

    class ProgressBar

      def initialize table_name, total
        @total = total
        @table_name = table_name
        @progress_bar = PowerBar.new if show_progress_env
      end

      def show index
        if show_progress? index
          show_progress index
        end
      end

      def close
        @progress_bar.close if @progress_bar
      end

      protected

      def show_progress? index
        show_progress_env && (started(index) || regular_interval(index) || complete(index))
      end

      def show_progress_env
        ENV['show_progress'] == "false" ? false : true
      end

      def show_progress index
        msg = "Table: %-15s [ %6d/%-6d ]" % [@table_name, index, @total]
        @progress_bar.show(:msg => msg, :done => index, :total => @total)
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


    end

  end
end