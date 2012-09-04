require 'bigdecimal'

module DataAnon
  module Strategy
    module Field
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