module DataAnon
  module Strategy
    module Field
      class RandomFloatDelta

        DEFAULT_DELTA = 10.0

        def initialize delta = DEFAULT_DELTA
          @delta = delta
        end

        def anonymize field
           return range(field.value-@delta,field.value+@delta)
        end

        def range (min, max)
          Random.new.rand * (max-min) + min
        end


      end
    end
  end
end