module DataAnon
  module Strategy
    module Field

      # Randomly picks up last name from the predefined list in the file. Default [file](https://raw.github.com/sunitparekh/data-anonymization/master/resources/last_names.txt) is part of the gem.
      # File should contain last name on each line.
      #
      #    !!!ruby
      #    anonymize('LastName').using FieldStrategy::RandomLastName.new
      #
      #    !!!ruby
      #    anonymize('LastName').using FieldStrategy::RandomLastName.new('my_last_names.txt')

      class RandomLastName < SelectFromFile

        def initialize file_path = nil
          super(file_path || DataAnon::Utils::Resource.file('last_names.txt'))
        end

      end
    end
  end
end