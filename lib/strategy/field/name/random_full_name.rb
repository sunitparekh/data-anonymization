module DataAnon
  module Strategy
    module Field

      # Generates full name using the RandomFirstName and RandomLastName strategies.
      #
      #    !!!ruby
      #    anonymize('FullName').using FieldStrategy::RandomFullName.new
      #
      #    !!!ruby
      #    anonymize('FullName').using FieldStrategy::RandomLastName.new('my_first_names.txt', 'my_last_names.txt')

      class RandomFullName

        def initialize first_names = nil, last_names = nil
          @first_name_anonymizer = DataAnon::Strategy::Field::RandomFirstName.new(first_names)
          @last_name_anonymizer = DataAnon::Strategy::Field::RandomLastName.new(last_names)
        end

        def anonymize field

          name_words = field.value.split(' ')

          anonymized_first_name = @first_name_anonymizer.anonymize(field)
          anonymized_last_name = ""
          for counter in (1..name_words.size-1)
            anonymized_last_name = anonymized_last_name + " " + @last_name_anonymizer.anonymize(field)
          end

          return anonymized_first_name + anonymized_last_name

        end
      end
    end
  end
end