require 'parallel'

module DataAnon
  module Parallel
    class Table

      def anonymize tables
        ::Parallel.each(tables) do |table|
          table.progress_bar = DataAnon::Utils::ParallelProgressBar
          table.process
        end
      end

    end
  end
end