module DataAnon
  module Strategy
    module Field
      class RandomIntegerDelta

        DEFAULT_DELTA = 10

        def initialize delta = nil
          @delta = delta || DEFAULT_DELTA

        end

        def anonymize field
          adjustment = DataAnon::Utils::RandomInt.generate(-@delta,@delta)
          return field.value + adjustment
        end
      end

    end
  end
end