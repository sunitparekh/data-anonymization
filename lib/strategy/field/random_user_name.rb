module DataAnon
  module Strategy
    module Field

      class RandomUserName

        DEFAULT_MIN_LENGTH = 5
        DEFAULT_MAX_LENGTH = 10

        def initialize min_length = nil, max_length = nil

          @min_length = min_length || DEFAULT_MIN_LENGTH
          @max_length = max_length || DEFAULT_MAX_LENGTH

          @string_util = DataAnon::Utils::StringUtils.new
          @number_util = DataAnon::Utils::NumberUtils.new

        end

        def anonymize field

          username_length = @number_util.generate_random_int(@min_length,@max_length)
          return @string_util.generate_random_string(username_length)

        end
      end
    end
  end
end