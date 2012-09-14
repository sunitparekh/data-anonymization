module DataAnon
  module Strategy
    module MongoDB
      class AnonymizeField

        def initialize field, field_strategy, anonymization_strategy
          @field = field
          @field_strategy = field_strategy
          @anonymization_strategy = anonymization_strategy
        end

        def anonymize
          if sub_document?
            @anonymization_strategy.anonymize_document(@field.value, @field.row_number, @field_strategy)
          elsif sub_documents?
            anonymize_sub_documents
          else
            anonymize_field
          end
        end

        def anonymize_sub_documents
          @field.value.collect { |value| @anonymization_strategy.anonymize_document(value, @field.row_number, @field_strategy) }
        end

        def anonymize_field
          @field_strategy = @field_strategy || @anonymization_strategy.default_strategy(@field.name)
          raise "Improper fields strategy defined for '#{@field.name}' within document \n #{@field.ar_record}" unless @field_strategy.respond_to?(:anonymize)
          @field_strategy.anonymize(@field)
        end

        def sub_documents?
          @field.value.kind_of?(Array) && @field.value[0].kind_of?(Hash)
        end

        def sub_document?
          @field.value.kind_of? Hash
        end


      end
    end
  end
end