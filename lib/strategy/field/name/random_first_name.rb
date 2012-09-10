module DataAnon
  module Strategy
    module Field

      # Randomly picks up first name from the predefined list in the file. Default [file](https://raw.github.com/sunitparekh/data-anonymization/master/resources/first_names.txt) is part of the gem.
      # File should contain first name on each line.
      #
      #    !!!ruby                                                                                                                                                                                                                                        ```ruby
      #    anonymize('FirstName').using FieldStrategy::RandomFirstName.new
      #
      #    !!!ruby
      #    anonymize('FirstName').using FieldStrategy::RandomFirstName.new('my_first_names.txt')
      #

      class RandomFirstName < SelectFromFile

        def initialize file_path = nil
          super(file_path || DataAnon::Utils::Resource.file('first_names.txt'))
        end

      end
    end
  end
end