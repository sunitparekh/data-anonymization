require 'powerbar'

module DataAnon
  module Utils

    class ProgressBar

      def initialize table_name, total
        @total = total
        @table_name = table_name
        @progress_bar = PowerBar.new if total > 0 && show_progress
      end

      def show_progress
        ENV['show_progress'] != 'false'
      end

      def show index
        if @progress_bar && ((index % 1000 == 0) || (index == @total) || (index == 1))
          @progress_bar.show(:msg => "Table: #{@table_name} (#{index}/#{@total})", :done => index, :total => @total)
        end
      end

      def close
        @progress_bar.close if @progress_bar
      end

    end

  end
end