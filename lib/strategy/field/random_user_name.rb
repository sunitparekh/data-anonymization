module DataAnon
  module Strategy
    module Field

      class RandomUserName

        DEFAULT_MIN_LENGTH = 5
        DEFAULT_MAX_LENGTH = 10

        def initialize min_length = nil, max_length = nil

          @min_length = min_length || DEFAULT_MIN_LENGTH
          @max_length = max_length || DEFAULT_MAX_LENGTH

        end

        def anonymize field

          username_length = Random.new.rand @min_length...@max_length
          return rand(36**username_length).to_s(36)

        end
      end
    end
  end
end