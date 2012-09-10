require 'mongo'

module DataAnon
  module Strategy
    module MongoDB
      class Whitelist < DataAnon::Strategy::Base

        def collection field, &block
          whitelist = self.class.new @source_database, @destination_database, @name, @user_strategies
          whitelist.process_fields &block
          @fields[field] = whitelist.fields
        end

        alias :document :collection

        def dest_collection
          database = @destination_database
          @dest_collection ||= mongo_collection(database)
        end

        def mongo_collection(database)
          options = database[:options] || {}
          Mongo::Connection.from_uri(database[:mongodb_uri], options)[database[:database]][@name]
        end

        def source_collection
          @source_collection ||= mongo_collection(@source_database)
        end


        def process
          logger.debug "Processing table #{@name}"
          total = source_collection.count
          if total > 0
            index = 1
            progress_bar = DataAnon::Utils::ProgressBar.new @name, total
            source_collection.find.each do |document|
              process_document index, document
              index += 1
              progress_bar.show(index)
            end
            progress_bar.close
          end
        end

        def process_document index, document
          dest_collection.insert anonymize_document(document, index, @fields)
        end

        def anonymize_document document, index, field_strategies = {}
          anonymized_document = {}
          document.each do |field_name, field_value|
            field_strategy = field_strategies[field_name.downcase]
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, document)
              anonymized_document[field.name] = anonymize_field1(field, field_strategy)
            end
          end
          anonymized_document
        end

        def anonymize_field1(field, field_strategy)
          if sub_document? field
            anonymize_document(field.value, field.row_number, field_strategy)
          elsif sub_documents? field
            anonymize_array(field_strategy, field)
          else
            anonymize_field(field_strategy, field)
          end
        end

        def anonymize_array(field_strategy, field)
          field.value.collect { |value| anonymize_document(value, field.row_number, field_strategy) }
        end

        def anonymize_field(field_strategy, field)
          field_strategy = field_strategy || DataAnon::Strategy::Field::DefaultAnon.new(@user_strategies)
          field_strategy.anonymize(field)
        end

        def sub_documents?(field)
          field.value.kind_of?(Array) && field.value[0].kind_of?(Hash)
        end

        def sub_document?(field)
          field.value.kind_of? Hash
        end

      end

    end
  end
end
