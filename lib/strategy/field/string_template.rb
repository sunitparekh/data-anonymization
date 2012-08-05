module DataAnon
  module Strategy
    module Field


      class StringTemplate

        def initialize template
          @template = template
        end

        def anonymize field
          eval ('"' + @template + '"')
        end

      end


    end
  end
end