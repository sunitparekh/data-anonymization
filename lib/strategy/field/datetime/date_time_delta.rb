module DataAnon
  module Strategy
    module Field

      # Shifts data randomly within given range. Default shifts date within 10 days + or - and shifts time within 30 minutes.
      #
      #    !!!ruby
      #    anonymize('DateOfBirth').using FieldStrategy::DateTimeDelta.new
      #
      #    !!!ruby
      #    # shifts date within 20 days and time within 50 minutes
      #    anonymize('DateOfBirth').using FieldStrategy::DateTimeDelta.new(20, 50)


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