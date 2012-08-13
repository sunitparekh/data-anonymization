module DataAnon
  module Utils
    class NumberUtils

      DEFAULT_MIN = 1
      DEFAULT_MAX = 100

      def initialize

      end

      def generate_random_int min = nil, max = nil
        @min = min || DEFAULT_MIN
        @max = max || DEFAULT_MAX
        Random.new.rand @min...@max
      end
    end
  end
end