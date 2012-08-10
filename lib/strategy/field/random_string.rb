module DataAnon
  module Strategy
    module Field
      class RandomString
        def initialize

        end

        def anonymize field

          original_string = field.value
          string_words = original_string.split(' ')
          anonymized_string = ""

          string_words.each do |word|
            anonymized_string = anonymized_string + rand(36**word.length).to_s(36) + " "
          end

          anonymized_string.strip

        end
      end
    end
  end
end