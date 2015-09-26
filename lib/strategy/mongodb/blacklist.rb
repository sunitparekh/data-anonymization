module DataAnon
  module Strategy
    module MongoDB
      class Blacklist < DataAnon::Strategy::MongoDB::Whitelist

        def self.whitelist?
          false
        end

        def process_record index, document
          anonymized_document = anonymize_document(document, index, @fields)
          source_collection.find({'_id' => anonymized_document['_id']}).update_one(anonymized_document)
        end

        def anonymize_document document, index, field_strategies = {}
          field_strategies.each do |field_name, field_strategy|
            field_value = document[field_name]
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, document, @name)
              document[field.name] = AnonymizeField.new(field, field_strategy, self).anonymize
            end
          end
          document
        end

      end

    end
  end
end
