module DataAnon
  module Strategy
    module Field

      # Keeping the format same it changes each digit in the string with random digit.
      #
      #    !!!ruby
      #    anonymize('CreditCardNumber').using FieldStrategy::FormattedStringNumber.new

      class FormattedStringNumber

        def anonymize field
          @original_string = field.value
          @anonymized_string = ""
          @original_string.each_char do |char|
            if /\d/.match(char).nil?
              @anonymized_string += char
            else
              @anonymized_string += DataAnon::Utils::RandomInt.generate(0,9).to_s
            end
          end

          @anonymized_string
        end

      end


    end
  end
end