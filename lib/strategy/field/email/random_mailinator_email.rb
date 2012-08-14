module DataAnon
  module Strategy
    module Field

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