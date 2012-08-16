module DataAnon
  module Strategy
    module Field

      class SelectFromFile

        def initialize file_path
          @values = File.read(file_path).split
        end

        def anonymize field
          @values.sample
        end

      end
    end
  end
end