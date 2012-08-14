module DataAnon
  module Strategy
    module Field

      class AnonymizeTime

        DEFAULT_ANONYMIZATION = true

        def self.only_month
          self.new true, false, false, false, false
        end

        def self.only_day
          self.new false, true, false, false, false
        end

        def self.only_hour
          self.new false, false, true, false, false
        end

        def self.only_minute
          self.new false, false, false, true, false
        end

        def initialize anonymize_month = DEFAULT_ANONYMIZATION, anonymize_day = DEFAULT_ANONYMIZATION, anonymize_hour = DEFAULT_ANONYMIZATION, anonymize_min = DEFAULT_ANONYMIZATION, anonymize_sec = DEFAULT_ANONYMIZATION

          @anonymize_month = anonymize_month
          @anonymize_day = anonymize_day
          @anonymize_hour = anonymize_hour
          @anonymize_min = anonymize_min
          @anonymize_sec = anonymize_sec

        end

        def anonymize field

          provided_time = field.value
          year = provided_time.year
          month = @anonymize_month? DataAnon::Utils::RandomInt.generate(1,12) : provided_time.month
          day = @anonymize_day? DataAnon::Utils::RandomInt.generate(1,31) : provided_time.day
          hour = @anonymize_hour? DataAnon::Utils::RandomInt.generate(1,24) : provided_time.hour
          min = @anonymize_min? DataAnon::Utils::RandomInt.generate(1,60) : provided_time.min
          sec = @anonymize_sec? DataAnon::Utils::RandomInt.generate (1,60) : provided_time.sec

          create_object(day, hour, min, month, sec, year)
        end

        private

        def create_object(day, hour, min, month, sec, year)
          Time.new(year, month, day, hour, min, sec)
        end

      end
    end
  end
end