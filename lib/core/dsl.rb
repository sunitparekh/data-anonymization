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

        def primary field
          @primary_key = field
        end

        def whitelist *fields
          fields.each { |f| @fields[f] = "whitelist" }
        end

        def default_anonymize *fields
          fields.each { |f| @fields[f] = "default" }
        end

        def process
          p "--------------- Processing table #{@name} -----------------"
          source = Utils::BaseTable.create(@name, @primary_key)
          source.establish_connection(@source)
          p source.count
          dest = Utils::BaseTable.create("Abc", @primary_key)
          dest.establish_connection(@destination)
          p source.count
          source.all.each do |record|
            p "processing record #{record}"
            #dest_record = dest.new(record.attributes)
            #dest_record.save!
          end
        end
      end
    end
  end
end

extend DataAnonymization::Core::DSL
Module.send(:include, DataAnonymization::Core::DSL)

