module DataAnon
  module Strategy
    class Whitelist < DataAnon::Strategy::Base

      def process_record(index, record)
        dest_record_map = {}
        record.attributes.each do |field_name, field_value|
          unless field_value.nil? || field_name.downcase == @primary_key.downcase
            field = DataAnon::Core::Field.new(field_name, field_value, index, record)
            field_strategy = @fields[field_name.downcase] || DataAnon::Strategy::Field::DefaultAnon.new(@user_strategies)
            dest_record_map[field_name] = field_strategy.anonymize(field)
          end
        end
        dest_record = dest_table.new dest_record_map
        dest_record[@primary_key] = record[@primary_key]
        dest_record.save!
      end

    end
  end
end
