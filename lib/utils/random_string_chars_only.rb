module DataAnon
  module Utils
    class RandomStringCharsOnly

      CHARS = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ'

      def self.generate length = nil
        RandomString.generate length, CHARS
      end
    end
  end
end