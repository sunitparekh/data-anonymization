module DataAnon
  module Strategy
    module Field

      class SelectFromFile

        def initialize file_path
          @values = File.read(file_path).split
        end

        def anonymize field
          return @values.sample(field.value.length) if field.value.kind_of? Array
          @values.sample
        end

      end
    end
  end
end