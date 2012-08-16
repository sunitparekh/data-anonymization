module DataAnon
  module Utils
    class RandomFloat

      def self.generate min, max
        return 0 if (min == 0.0 && max == 0.0)
        Random.new.rand * (max-min) + min
      end

    end
  end
end