module DataAnon
  module Strategy
    module MongoDB
      class Blacklist < DataAnon::Strategy::MongoDB::Whitelist

        def process_document index, document
          source_collection.save anonymize_document(document, index, @fields)
        end

        def anonymize_document document, index, field_strategies = {}
          field_strategies.each do |field_name, field_strategy|
            field_value = document[field_name]
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, document)
              document[field.name] = AnonymizeField.new(field, field_strategy, self).anonymize
            end
          end
          document
        end

      end

    end
  end
end
