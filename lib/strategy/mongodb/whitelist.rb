require 'mongo'

class Mongo::Collection
  alias :all :find
end

module DataAnon
  module Strategy
    module MongoDB
      class Whitelist < DataAnon::Strategy::Base

        def self.whitelist?
          true
        end

        def collection field, &block
          whitelist = self.class.new @source_database, @destination_database, @name, @user_strategies
          whitelist.process_fields &block
          @fields[field] = whitelist.fields
        end

        alias :document :collection

        def mongo_collection(database)
          options = database[:options] || {}
          Mongo::Connection.from_uri(database[:mongodb_uri], options)[database[:database]][@name]
        end

        def dest_collection
          database = @destination_database
          @dest_collection ||= mongo_collection(database)
        end

        def source_collection
          @source_collection ||= mongo_collection(@source_database)
        end

        alias :source_table :source_collection
        alias :dest_table :dest_collection

        def process_record index, document
          dest_collection.insert anonymize_document(document, index, @fields)
        end

        def anonymize_document document, index, field_strategies = {}
          anonymized_document = {}
          document.each do |field_name, field_value|
            field_strategy = field_strategies[field_name.downcase]
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, document, @name)
              anonymized_document[field.name] = AnonymizeField.new(field, field_strategy, self).anonymize
            end
          end
          anonymized_document
        end


      end

    end
  end
end
