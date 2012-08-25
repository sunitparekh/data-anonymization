require 'parallel'

module DataAnon
  module Parallel
    class Table

      def anonymize tables
        ::Parallel.each(tables) { |table| table.process }
      end

    end
  end
end