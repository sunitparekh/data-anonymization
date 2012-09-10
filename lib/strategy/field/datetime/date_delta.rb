module DataAnon
  module Strategy
    module Field

      # Shifts date randomly within given delta range. Default shits date within 10 days + or -
      #
      #    !!!ruby
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.new
      #
      #    !!!ruby
      #    # shifts date within 25 days
      #    anonymize('DateOfBirth').using FieldStrategy::DateDelta.new(25)


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