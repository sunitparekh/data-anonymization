module DataAnon
  module Strategy
    module Field
      class RandomFloatDelta

        def initialize delta = 10.0
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