module DataAnon
  module Strategy
    module Field


      class RandomPhoneNumber

        def initialize

        end

        def anonymize field
          @original_phone_number = field.value
          @anonymized_phone_number = ""
          @original_phone_number.each_char do |char|
            if /\d/.match(char).nil?
              @anonymized_phone_number += char
            else
              @anonymized_phone_number += DataAnon::Utils::RandomInt.generate(0,9).to_s
            end
          end

          @anonymized_phone_number
        end
      end
    end
  end
end