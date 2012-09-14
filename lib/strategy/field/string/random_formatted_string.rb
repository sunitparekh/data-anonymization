module DataAnon
  module Strategy
    module Field

      # Keeping the format same it changes each digit with random digit, character with character preserving the case.
      #
      #    !!!ruby
      #    anonymize('PhoneNumber').using FieldStrategy::RandomFormattedString.new
      #    anonymize('Email').using FieldStrategy::RandomFormattedString.new

      class RandomFormattedString

        SMALL_CHARS = "abcdefghjkmnpqrstuvwxyz"
        CAPS_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ"

        def anonymize field
          @original_string = field.value
          @anonymized_string = ""
          @original_string.each_char do |char|
            if /\d/.match(char)
              @anonymized_string += DataAnon::Utils::RandomInt.generate(0, 9).to_s
            elsif /[a-z]/.match(char)
              @anonymized_string += SMALL_CHARS[rand(SMALL_CHARS.length)]
            elsif /[A-Z]/.match(char)
              @anonymized_string += CAPS_CHARS[rand(CAPS_CHARS.length)]
            else
              @anonymized_string += char
            end
          end

          @anonymized_string
        end

      end


    end
  end
end