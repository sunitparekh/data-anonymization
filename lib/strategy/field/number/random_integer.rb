module DataAnon
  module Strategy
    module Field

      # Generates random integer number between given two numbers. Default range is 0 to 100.
      #
      #    !!!ruby
      #    anonymize('Age').using FieldStrategy::RandomInteger.new(18,70)

      class RandomInteger

        def initialize from = 0, to = 100
          @from = from
          @to = to

        end

        def anonymize field
          DataAnon::Utils::RandomInt.generate(@from,@to)
        end

      end


    end
  end
end