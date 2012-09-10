module DataAnon
  module Strategy
    module Field

      # Generates random email using mailinator hostname. e.g. <randomstring>@mailinator.com
      #
      #    !!!ruby
      #    anonymize('Email').using FieldStrategy::RandomMailinatorEmail.new

      class RandomMailinatorEmail

        def initialize
          @email_anonymizer = DataAnon::Strategy::Field::RandomEmail.new("mailinator","com")
        end

        def anonymize field
          return @email_anonymizer.anonymize(field)
        end
      end
    end

  end
end