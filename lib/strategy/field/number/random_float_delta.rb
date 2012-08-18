module DataAnon
  module Strategy
    module Field
      class RandomFloatDelta

        def initialize delta = 10.0
          @delta = delta
        end

        def anonymize field
          return field.value + DataAnon::Utils::RandomFloat.generate(-@delta, +@delta)
        end

      end
    end
  end
end