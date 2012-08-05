module DataAnon
  module Strategy
    module Field


      class StringTemplate

        def anonymize field
          "Sunit Parekh #{field.row_index}"
        end

      end


    end
  end
end