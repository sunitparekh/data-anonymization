module DataAnon
  module Strategy
    module Field

      class DefaultAnon

        def anonymize field
          field.value
        end

      end


    end
  end
end