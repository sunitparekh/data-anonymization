module DataAnon
  module Utils
    class RandomStringCharsOnly

      def self.generate length = nil
        RandomString.generate length, 'abcdefghjkmnpqrstuvwxyz'
      end
    end
  end
end