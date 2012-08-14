module DataAnon
  module Strategy
    module Field

      class SelectFromFile

        def initialize file_path
          @values = File.read(file_path).split
        end

        def anonymize field
          return @values[DataAnon::Utils::RandomInt.generate(0,(@values.length - 1))]
        end

      end
    end
  end
end