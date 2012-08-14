module DataAnon
  module Strategy
    module Field


      class SelectFromList < SelectFromFile

        def initialize values
          @values = values.class == Array ? values : [values]
        end

      end


    end
  end
end