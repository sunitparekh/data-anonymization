module DataAnon
  module Strategy
    module Field

      class RandomUserName

        DEFAULT_MIN_LENGTH = 5
        DEFAULT_MAX_LENGTH = 10

        def initialize min_length = DEFAULT_MIN_LENGTH, max_length = DEFAULT_MAX_LENGTH
          @min_length = min_length
          @max_length = max_length
        end

        def anonymize field
          username_length = DataAnon::Utils::RandomInt.generate(@min_length,@max_length)
          return DataAnon::Utils::RandomString.generate(username_length)

        end
      end
    end
  end
end