module DataAnon
  module Utils
    class StringUtils

      def initialize

      end

      def generate_random_string length = nil
        if length.nil?
          length = Random.new.rand 5...15
        end

        rand(36**length).to_s(36)
      end
    end
  end
end