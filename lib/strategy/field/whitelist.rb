module DataAnon
  module Strategy
    module Field


      class Whitelist

        def anonymize field
          field.value
        end

      end


    end
  end
end