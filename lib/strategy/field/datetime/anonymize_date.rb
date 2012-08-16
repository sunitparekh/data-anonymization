module DataAnon
  module Strategy
    module Field

      class AnonymizeDate


        def self.only_month
          self.new true, false
        end

        def self.only_day
          self.new false, true
        end

        def initialize anonymize_month, anonymize_day

          @anonymize_month = anonymize_month
          @anonymize_day = anonymize_day

        end

        def anonymize field

          original_time = field.value

          year = original_time.year
          month = @anonymize_month? DataAnon::Utils::RandomInt.generate(1,12) : original_time.month
          days_in_month = Time.new(year,month,1,1,1,1).end_of_month.day
          day = @anonymize_day? DataAnon::Utils::RandomInt.generate(1,days_in_month) : original_time.day

          Date.new(year, month, day)
        end


      end
    end
  end
end