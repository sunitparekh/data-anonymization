module DataAnon
  module Strategy
    module Field


      class Anonymous

        def initialize &block
          @block = block
        end

        def anonymize field
          @block.call field
        end

      end


    end
  end
end