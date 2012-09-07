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
          @dest_collection ||= Mongo::Connection.from_uri(@destination_database[:mongodb_uri])[@destination_database[:database]][@name]
        end

        def source_collection
          @source_collection ||= Mongo::Connection.from_uri(@source_database[:mongodb_uri])[@source_database[:database]][@name]
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

        def anonymize_document document, index, document_fields = {}
          anonymized_document = {}
          document.each do |field_name, field_value|
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, document)
              if sub_document? field.value
                anonymized_document[field.name] = anonymize_document(field.value,index, document_fields[field.name])
              elsif field.value.kind_of? Array
                if sub_document? field.value[0]
                  anonymized_document[field.name] = field.value.collect { |value| anonymize_document(value,index, document_fields[field.name]) }
                else
                  anonymized_document[field.name] = anonymize_field(document_fields, field)
                end
              else
                anonymized_document[field.name] = anonymize_field(document_fields, field)
              end
            end
          end
          anonymized_document
        end

        def anonymize_field(document_fields, field)
          field_strategy = document_fields[field.name.downcase] || DataAnon::Strategy::Field::DefaultAnon.new(@user_strategies)
          field_strategy.anonymize(field)
        end

        def sub_document?(field_value)
          field_value.kind_of? Hash
        end

      end

    end
  end
end
