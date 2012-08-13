module DataAnon
  module Strategy
    module Field


      class RandomBoolean

        BOOL_VALUES = [true,false]
        def initialize
        end

        def anonymize field
           BOOL_VALUES.sample
        end

      end


    end
  end
end