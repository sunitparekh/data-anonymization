module DataAnon
  module Utils
    class RandomInt

      DEFAULT_MIN = 1
      DEFAULT_MAX = 100

      def self.generate min = nil, max = nil
        return 0 if (min == 0 && max == 0)
        @min = min || DEFAULT_MIN
        @max = max || DEFAULT_MAX
        Random.new.rand @min...@max
      end
    end
  end
end