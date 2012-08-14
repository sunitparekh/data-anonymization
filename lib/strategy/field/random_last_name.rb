module DataAnon
  module Strategy
    module Field

      class RandomLastName < SelectFromFile

        def initialize file_path = nil
          super(file_path || DataAnon::Utils::Resource.file('last_names.txt'))
        end

      end
    end
  end
end