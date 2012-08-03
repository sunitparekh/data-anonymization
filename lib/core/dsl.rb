module DataAnonymization
  module Core
    module DSL
      def database(name, source, destination , &block)
        p "******* Processing Database: #{name} ********"
        @source = source
        @destination = destination
        yield block
      end

      def table (name, &block)
        TableDef.new(name, @source, @destination).fields(&block).process
      end

      class TableDef
        def initialize name, source, destination
          @name = name
          @source = source
          @destination = destination
          @fields = {}
        end

        def fields &block
          block.call self
          self
        end

        def whitelist *fields
          fields.each { |f| @fields[f.downcase] = Strategy::Whitelist }
        end

        def anonymize *fields
          fields.each { |f| @fields[f.downcase] = Strategy::Whitelist }
        end

        def process
          p "--------------- Processing table #{@name} -----------------"
          source = Utils::SourceTable.create @name
          dest = Utils::DestinationTable.create @name
          source.all.each do |record|
            p "processing record #{record.attributes}"
            dest_record_map = {}
            record.attributes.each do | field_name, field_value |
              dest_record_map[field_name] = @fields[field_name.downcase].new.process( field_name, field_value )
            end
            dest_record = dest.new dest_record_map
            dest_record.save!
          end
        end
      end
    end
  end
end

extend DataAnonymization::Core::DSL
Module.send(:include, DataAnonymization::Core::DSL)

