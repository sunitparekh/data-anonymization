module DataAnon
  module Strategy
    module Field


      class AnonymizeArray

        def self.user_defaults user_defaults
          @@user_defaults = user_defaults
        end

        def initialize strategy
          @strategy = strategy
        end

        def anonymize field
          field.value.collect do |v|
            strategy = @strategy || @@user_defaults[v.class.to_s.downcase.to_sym]
            strategy.anonymize DataAnon::Core::Field.new(field.name, v, field.row_number, field.ar_record, field.table_name)
          end
        end

      end


    end
  end
end