module DataAnon
  module Strategy
    class Blacklist < DataAnon::Strategy::Base

      def process
        source = Utils::SourceTable.create @name, @primary_key
        logger.debug "Processing table #{@name} with fields strategy using #{@fields}"
        progress_logger.info "Table: #{@name} (#{source.count} records) "
        index = 1
        source.find_each(:batch_size => 2) do |record|
          progress_logger.info "."
          @fields.each do |field, strategy|
            database_field_name = record.attributes.select { |k,v| k.downcase == field }.keys[0]
            field_value = record.attributes[database_field_name]
            unless field_value.nil?
              field = DataAnon::Core::Field.new(database_field_name, field_value, index, record)
              record[database_field_name] = strategy.anonymize(field)
            end
          end
          record.save!
          index += 1
        end
        progress_logger.info " DONE\n"
      end
    end
  end
end
