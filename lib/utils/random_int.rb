module DataAnon
  module Utils
    class RandomInt

      def self.generate min, max
        return 0 if (min == 0 && max == 0)
        Random.new.rand min..max
      end
    end
  end
end
