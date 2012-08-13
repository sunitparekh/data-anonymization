module DataAnon
  module Utils
    class RandomInt

      DEFAULT_MIN = 1
      DEFAULT_MAX = 100

      def self.generate min = nil, max = nil
        @min = min || DEFAULT_MIN
        @max = max || DEFAULT_MAX
        Random.new.rand @min...@max
      end
    end
  end
end