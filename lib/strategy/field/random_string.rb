module DataAnon
  module Strategy
    module Field
      class RandomString
        def initialize
          @string_util = DataAnon::Utils::StringUtils.new
        end

        def anonymize field

          original_string = field.value
          string_words = original_string.split(' ')
          anonymized_string = ""

          string_words.each do |word|
            anonymized_string = anonymized_string + @string_util.generate_random_string(word.length) + " "
          end

          anonymized_string.strip

        end
      end
    end
  end
end