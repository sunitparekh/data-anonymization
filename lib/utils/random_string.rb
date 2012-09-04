module DataAnon
  module Utils
    class RandomString

      RANDOM_STRING_CHARS = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'

      def self.generate length = nil, chars = RANDOM_STRING_CHARS
        length ||= Random.new.rand 5...15
        random_string = ''
        length.times { random_string << chars[rand(chars.size)] }
        random_string
      end
    end
  end
end