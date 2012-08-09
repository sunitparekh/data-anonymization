module DataAnon
  module Strategy
    module Field

      class RandomFullName

        def initialize

          @first_name_anonymizer = DataAnon::Strategy::Field::RandomFirstName.new()
          @last_name_anonymizer = DataAnon::Strategy::Field::RandomLastName.new()

        end

        def anonymize field

          name_words = field.value.split(' ')

          anonymized_first_name = @first_name_anonymizer.anonymize(name_words[0])
          anonymized_last_name = ""
          for counter in (1..name_words.size-1)
            anonymized_last_name = anonymized_last_name + " " + @last_name_anonymizer.anonymize(name_words[counter])
          end

          return anonymized_first_name + anonymized_last_name

        end
      end
    end
  end
end