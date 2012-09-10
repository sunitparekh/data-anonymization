module DataAnon
  module Strategy
    module Field

      # Generates random string of same length.
      #
      #   !!!ruby
      #   anonymize('UserName').using FieldStrategy::RandomString.new

      class RandomString

        def anonymize field

          original_string = field.value
          string_words = original_string.split(' ')
          anonymized_string = ""

          string_words.each do |word|
            anonymized_string = anonymized_string + DataAnon::Utils::RandomString.generate(word.length) + " "
          end

          anonymized_string.strip

        end
      end
    end
  end
end