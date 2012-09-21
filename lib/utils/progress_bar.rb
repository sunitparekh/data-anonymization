require 'powerbar'

module DataAnon
  module Utils

    class ProgressBar

      def initialize table_name, total
        @total = total
        @table_name = table_name
        @power_bar = PowerBar.new if show_progress_env
        apply_power_bar_settings  if show_progress_env
      end

      def apply_power_bar_settings
        @power_bar.settings.tty.finite.template.main = \
        "${<msg>} ${<bar> }\e[0m${<rate>/s} \e[33;1m${<percent>%} " +
            "\e[36;1m${<elapsed>}\e[31;1m${ ETA: <eta>}"
        @power_bar.settings.tty.finite.template.padchar = "\e[0m\u2589"
        @power_bar.settings.tty.finite.template.barchar = "\e[34;1m\u2589"
        @power_bar.settings.tty.finite.template.exit = "\e[?25h\e[0m" # clean up after us
        @power_bar.settings.tty.finite.template.close = "\e[?25h\e[0m\n" # clean up after us
        @power_bar.settings.tty.finite.output = Proc.new { |s| $stderr.print s }
      end

      def show index
        if show_progress? index
          show_progress index
        end
      end

      def close
        @power_bar.close if @power_bar
      end

      protected

      def show_progress? index
        show_progress_env && (started(index) || regular_interval(index) || complete(index))
      end

      def show_progress_env
        ENV['show_progress'] == "false" ? false : true
      end

      def show_progress counter
        sleep 0.1
        msg = "%-20s [%6d/%-6d]" % [@table_name, counter, @total]
        @power_bar.show({:msg => msg, :done => counter, :total => @total})
      end

      def complete index
        index == @total
      end

      def regular_interval index
        (index % 1000) == 0
      end

      def started index
        index == 1
      end


    end

  end
end