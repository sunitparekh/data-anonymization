module DataAnon
  module Strategy
    module Field

      # Keeping the format same it changes each digit in the string with random digit.
      #
      #    !!!ruby
      #    anonymize('PhoneNumber').using FieldStrategy::RandomPhoneNumber.new

      class RandomPhoneNumber < FormattedStringNumber

      end


    end
  end
end