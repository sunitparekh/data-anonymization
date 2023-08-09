module DataAnon
  module Strategy
    module MongoDB
      class Blacklist < DataAnon::Strategy::MongoDB::Whitelist
        def self.whitelist?
          false
        end

        def process_record(index, document)
          id = document["_id"]
          begin
            anonymized_document = anonymize_document(document, index, @fields)
            updates = flatten_for_update anonymized_document
            # skip empty documents/updates
            if ((updates.kind_of?(Array) || updates.kind_of?(Hash)) && updates.size == 0)
              return;
            end
            # differential mongodb update via { $set: { 'doc.nested.array.0.attr': 'value' }}
            source_collection.update_one({ "_id" => id }, { "$set" => updates })
          rescue StandardError => e
            puts e.message
          end
        end

        def anonymize_document(document, index, field_strategies = {})
          anonymized_document = {}
          field_strategies.each do |field_name, field_strategy|
            field_value = document[field_name]
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, document, @name)
              result = AnonymizeField.new(field, field_strategy, self).anonymize
              if !((result.kind_of?(Array) || result.kind_of?(Hash)) && result.size == 0)
                anonymized_document[field.name] = result
              end
            end
          end
          anonymized_document
        end

        def flatten_for_update(object, level = 0, name = "", updates = {})
          path = name.to_s
          if object.is_a?(Array)
            if level > 0
              path += "."
            end
            object.each_with_index { |child, idx| flatten_for_update(child, level + 1, path + idx.to_s, updates) }
          elsif object.is_a?(Hash)
            if level > 0
              path += "."
            end
            object.each { |key, value| flatten_for_update(value, level + 1, path + key, updates) }
          else
            updates[path] = object.inspect
          end
          updates
        end

      end

    end
  end
end
