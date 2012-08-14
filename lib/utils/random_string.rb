module DataAnon
  module Utils
    class RandomString

      def self.generate length = nil
        length ||= Random.new.rand 5...15
        chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
        random_string = ''
        length.times { random_string << chars[rand(chars.size)] }
        random_string
      end
    end
  end
end