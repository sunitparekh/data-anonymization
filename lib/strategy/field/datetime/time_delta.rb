module DataAnon
  module Strategy
    module Field

      # Shifts data randomly within given range. Default shifts date within 10 days + or - and shifts time within 30 minutes.
      #
      #    !!!ruby
      #    anonymize('DateOfBirth').using FieldStrategy::TimeDelta.new
      #
      #    !!!ruby
      #    # shifts date within 20 days and time within 50 minutes
      #    anonymize('DateOfBirth').using FieldStrategy::TimeDelta.new(20, 50)

      class TimeDelta < DateTimeDelta
      end


    end
  end
end