module DataAnon
  module Strategy
    module Field
      class RandomIntegerDelta

        DEFAULT_DELTA = 10

        def initialize delta = nil
          @delta = delta || DEFAULT_DELTA
        end

        def anonymize field
          adjustment = Random.new.rand -@delta...@delta
          return field.value + adjustment
        end
      end

    end
  end
end