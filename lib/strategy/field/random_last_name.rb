module DataAnon
  module Strategy
    module Field

      class RandomLastName

        def initialize file_path = nil
          file = file_path || DataAnon::Utils::Resource.file('last_names.txt')
          @names = File.read(file).split
        end

        def anonymize field
          return @names[rand(@names.size)]
        end

      end
    end
  end
end