module DataAnon
  module Strategy
    module Field


      class RandomInt

        def initialize from = 0, to = 100
          @from = from
          @to = to
          @number_util = DataAnon::Utils::NumberUtils.new
        end

        def anonymize field
          @number_util.generate_random_int(@from,@to)
        end

      end


    end
  end
end