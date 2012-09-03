module DataAnon
  module Utils
    class RandomStringCharsOnly

      def self.generate length = nil
        length ||= Random.new.rand 5...15
        chars = 'abcdefghjkmnpqrstuvwxyz'
        random_string = ''
        length.times { random_string << chars[rand(chars.size)] }
        random_string
      end
    end
  end
end