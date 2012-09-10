module DataAnon
  module Strategy
    module Field

      # Shifts the current value randomly within given delta + and -. Default is 10
      #
      #    !!!ruby
      #    anonymize('Age').using FieldStrategy::RandomIntegerDelta.new(2)

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