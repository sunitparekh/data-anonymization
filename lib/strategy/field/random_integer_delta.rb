module DataAnon
  module Strategy
    module Field
      class RandomIntegerDelta

        DEFAULT_DELTA = 10

        def initialize delta = nil
          @delta = delta || DEFAULT_DELTA
          @number_util = DataAnon::Utils::NumberUtils.new
        end

        def anonymize field
          adjustment = @number_util.generate_random_int(-@delta,@delta)
          return field.value + adjustment
        end
      end

    end
  end
end