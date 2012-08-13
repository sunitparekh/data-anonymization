module DataAnon
  module Strategy
    module Field


      class RandomPhoneNumber

        def initialize
          @number_util = DataAnon::Utils::NumberUtils.new
        end

        def anonymize field
          @original_phone_number = field.value
          @anonymized_phone_number = ""
          @original_phone_number.each_char do |char|
            if /\d/.match(char).nil?
              @anonymized_phone_number += char
            else
              @anonymized_phone_number += @number_util.generate_random_int(0,9).to_s
            end
          end

          @anonymized_phone_number
        end
      end
    end
  end
end