module DataAnon
  module Strategy
    module Field


      class RandomSelection

        def initialize values
          @values = values
        end

        def anonymize field
          @values[Random.new.rand 0...(@values.length - 1)]
        end

      end


    end
  end
end