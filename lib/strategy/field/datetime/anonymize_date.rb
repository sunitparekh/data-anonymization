module DataAnon
  module Strategy
    module Field

      # Anonmizes day and month fields within natural range based on true/false input for that field. By defaut both fields are
      # anonymized
      #
      #    !!!ruby
      #    # anonymizes month and leaves day unchanged
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.new(true,false)
      #
      # In addition to customizing which fields you want anonymized, there are some helper methods which allow for quick anonymization
      #
      #                                                                                                                                                                                               ```ruby
      #    # anonymizes only the month field
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.only_month
      #    # anonymizes only the day field
      #    anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.only_day

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