module DataAnon
  module Strategy
    module Field
      class RandomIntegerDelta

        def initialize delta = 10
          @delta = delta
        end

        def anonymize field
          adjustment = DataAnon::Utils::RandomInt.generate(-@delta,@delta)
          return field.value + adjustment
        end
      end

    end
  end
end