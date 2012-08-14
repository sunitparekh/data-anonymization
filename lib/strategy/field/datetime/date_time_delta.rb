module DataAnon
  module Strategy
    module Field

      class DateTimeDelta

        DEFAULT_DAY_DELTA = 10
        DEFAULT_MINUTE_DELTA = 30

        def initialize day_delta = DEFAULT_DAY_DELTA, minute_delta = DEFAULT_MINUTE_DELTA
          @day_delta = day_delta
          @minute_delta =  minute_delta
        end

        def anonymize field
          day_adjustment = DataAnon::Utils::RandomInt.generate(-@day_delta,@day_delta)
          minute_adjustment = DataAnon::Utils::RandomInt.generate(-@minute_delta,@minute_delta)
          return field.value + (day_adjustment.days + minute_adjustment.minutes)
        end

      end
    end
  end
end