module DataAnon
  module Strategy
    module Field


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