require 'bigdecimal'

module DataAnon
  module Strategy
    module Field

      # Shifts the current value randomly within given delta + and -. Default is 10.0
      #
      #    !!!ruby
      #    anonymize('points').using FieldStrategy::RandomFloatDelta.new(2.5)

      class RandomBigDecimalDelta

        def initialize delta = 100.0
          @delta = delta
        end

        def anonymize field
          return BigDecimal.new("#{field.value + DataAnon::Utils::RandomFloat.generate(-@delta, +@delta)}")
        end

      end
    end
  end
end