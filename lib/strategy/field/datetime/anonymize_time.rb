module DataAnon
  module Strategy
    module Field

      # Anonymizes each field(except year and seconds) within the natural range (e.g. hour between 1-24 and day within the month) based on true/false
      # input for that field. By default, all fields are anonymized.
      #
      #    !!!ruby
      #    # anonymizes month and hour fields, leaving the day and minute fields untouched
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeTime.new(true,false,true,false)
      #
      # In addition to customizing which fields you want anonymized, there are some helper methods which allow for quick anonymization
      #
      #    !!!ruby
      #    # anonymizes only the month field
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeTime.only_month
      #    # anonymizes only the day field
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeTime.only_day
      #    # anonymizes only the hour field
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeTime.only_hour
      #    # anonymizes only the minute field
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeTime.only_minute

      class AnonymizeTime

        DEFAULT_ANONYMIZATION = true

        def self.only_month
          self.new true, false, false, false
        end

        def self.only_day
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
          hour = @anonymize_hour? DataAnon::Utils::RandomInt.generate(0,23) : original_time.hour
          min = @anonymize_min? DataAnon::Utils::RandomInt.generate(0,59) : original_time.min
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
