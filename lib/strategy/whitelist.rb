module DataAnon
  module Strategy
    class Whitelist < DataAnon::Strategy::Base

      def self.whitelist?
        true
      end

      def process_record(index, record)
        dest_record_map = {}
        record.attributes.each do |field_name, field_value|
          unless field_value.nil? || is_primary_key?(field_name)
            field = DataAnon::Core::Field.new(field_name, field_value, index, record, @name)
            field_strategy = @fields[field_name.downcase] || default_strategy(field_name)
            dest_record_map[field_name] = field_strategy.anonymize(field)
          end
        end
        dest_record = dest_table.new dest_record_map, without_protection: true
        @primary_keys.each do |key|
          dest_record[key] = record[key]
        end
        dest_record.save!
      end


    end
  end
end
