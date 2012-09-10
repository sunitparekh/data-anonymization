module DataAnon
  module Strategy
    module Field

      # Similar to SelectFromList only difference is the list of values are picked up from file. Classical usage is like states field anonymization.
      #
      #    !!!ruby
      #    anonymize('State').using FieldStrategy::SelectFromFile.new('states.txt')
      #

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