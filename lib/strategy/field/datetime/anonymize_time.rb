module DataAnon
  module Strategy
    module Field

      class AnonymizeTime

        DEFAULT_ANONYMIZATION = true

        def self.only_month
          self.new true, false, false, false
        end

        def self.only_date
          self.new false, true, false, false
        end

        def self.only_hour
          self.new false, false, true, false
        end

        def self.only_minute
          self.new false, false, false, true
        end

        def initialize anonymize_month, anonymize_day, anonymize_hour, anonymize_min

          @anonymize_month = anonymize_month
          @anonymize_day = anonymize_day
          @anonymize_hour = anonymize_hour
          @anonymize_min = anonymize_min

        end

        def anonymize field

          original_time = field.value

          year = original_time.year
          month = @anonymize_month? DataAnon::Utils::RandomInt.generate(1,12) : original_time.month
          days_in_month = Time.new(year,month,1,1,1,1).end_of_month.day
          day = @anonymize_day? DataAnon::Utils::RandomInt.generate(1,days_in_month) : original_time.day
          hour = @anonymize_hour? DataAnon::Utils::RandomInt.generate(1,24) : original_time.hour
          min = @anonymize_min? DataAnon::Utils::RandomInt.generate(1,60) : original_time.min
          sec = original_time.sec

          create_object(year, month, day, hour, min, sec)
        end

        private

        def create_object(year, month, day, hour, min, sec)
          Time.new(year, month, day, hour, min, sec)
        end

      end
    end
  end
end