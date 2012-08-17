module DataAnon
  module Strategy
    module Field


      class RandomZipcode < GeojsonBase

        def initialize file_path
          @values = DataAnon::Utils::GeojsonParser.zipcode(file_path)
        end

      end


    end
  end
end