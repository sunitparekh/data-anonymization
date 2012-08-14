module DataAnon
  module Strategy
    module Field


      class RandomInt

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