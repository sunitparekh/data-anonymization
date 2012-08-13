module DataAnon
  module Strategy
    class Whitelist < DataAnon::Strategy::Base

      def process
        source = Utils::SourceTable.create @name, @primary_key
        dest = Utils::DestinationTable.create @name, @primary_key
        logger.debug "Processing table #{@name} with fields strategy using #{@fields}"
        progress_logger.info "Table: #{@name} (#{source.count} records) "
        index = 1
        source.find_each(:batch_size => 2) do |record|
          progress_logger.info "."
          dest_record_map = {}
          record.attributes.each do | field_name, field_value |
            unless field_value.nil?
              field = DataAnon::Core::Field.new(field_name, field_value, index, record)
              field_strategy = @fields[field_name.downcase] || DataAnon::Strategy::Field::DefaultAnon.new(@user_strategies)
              dest_record_map[field_name] = field_strategy.anonymize(field)
            end
          end
          dest_record = dest.new dest_record_map
          dest_record.save!
          index += 1
        end
        progress_logger.info " DONE\n"
      end
    end
  end
end
