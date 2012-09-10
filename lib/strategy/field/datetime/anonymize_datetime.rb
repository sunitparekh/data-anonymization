module DataAnon
  module Strategy
    module Field

#      Anonymizes each field(except year and seconds) within the natural range (e.g. hour between 1-24 and day within the month) based on true/false
#      input for that field. By default, all fields are anonymized.
#
#      ```ruby
#      #anonymizes month and hour fields, leaving the day and minute fields untouched
#      anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.new(true,false,true,false)
#      ```
#
#      In addition to customizing which fields you want anonymized, there are some helper methods which allow for quick anonymization
#
#      ```ruby
#      # anonymizes only the month field
#      anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_month
#      # anonymizes only the day field
#      anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_day
#      # anonymizes only the hour field
#      anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_hour
#      # anonymizes only the minute field
#      anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_minute
#      ```

      class AnonymizeDateTime < AnonymizeTime

        private
        def create_object(year, month, day, hour, min, sec)
          DateTime.new(year, month, day, hour, min, sec)
        end

      end
    end
  end
end