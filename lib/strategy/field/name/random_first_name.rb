module DataAnon
  module Strategy
    module Field

      class RandomFirstName < SelectFromFile

        def initialize file_path = nil
          super(file_path || DataAnon::Utils::Resource.file('first_names.txt'))
        end

      end
    end
  end
end