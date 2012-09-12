module DataAnon
  module Strategy
    class Blacklist < DataAnon::Strategy::Base

      def process_record index, record
        @fields.each do |field, strategy|
          database_field_name = record.attributes.select { |k,v| k.downcase == field }.keys[0]
          field_value = record.attributes[database_field_name]
          unless field_value.nil? || is_primary_key?(database_field_name)
            field = DataAnon::Core::Field.new(database_field_name, field_value, index, record, @name)
            record[database_field_name] = strategy.anonymize(field)
          end
        end
        record.save!
      end

    end
  end
end
