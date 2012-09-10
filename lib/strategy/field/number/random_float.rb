module DataAnon
  module Strategy
    module Field

      # Generates random float number between given two numbers. Default range is 0.0 to 100.0
      #
      #    !!!ruby
      #    anonymize('points').using FieldStrategy::RandomFloat.new(3.0,5.0)

      class RandomFloat

        def initialize from = 0.0, to = 100.0
          @from = from
          @to = to

        end

        def anonymize field
          DataAnon::Utils::RandomFloat.generate(@from,@to)
        end

      end


    end
  end
end