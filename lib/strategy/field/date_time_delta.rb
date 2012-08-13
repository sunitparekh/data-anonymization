module DataAnon
  module Strategy
    module Field

      class DateTimeDelta

        DEFAULT_DAY_DELTA = 10
        DEFAULT_MINUTE_DELTA = 30

        def initialize day_delta = nil, minute_delta = nil

          @day_delta = day_delta || DEFAULT_DAY_DELTA
          @minute_delta =  minute_delta || DEFAULT_MINUTE_DELTA
          @number_util = DataAnon::Utils::NumberUtils.new

        end

        def anonymize field
          day_adjustment = @day_delta==0? 0 : (@number_util.generate_random_int(-@day_delta,@day_delta))
          minute_adjustment = @minute_delta==0? 0 :  (@number_util.generate_random_int(-@minute_delta,@minute_delta))
          return field.value + day_adjustment.days + minute_adjustment.minutes
        end

      end
    end
  end
end