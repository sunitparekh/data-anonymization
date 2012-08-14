module DataAnon
  module Strategy
    module Field

      class DateDelta

        DEFAULT_DAY_DELTA = 10

        def initialize day_delta = DEFAULT_DAY_DELTA
          @day_delta = day_delta
        end

        def anonymize field
          day_adjustment = DataAnon::Utils::RandomInt.generate(-@day_delta,@day_delta)
          return field.value + day_adjustment.days
        end

      end
    end
  end
end