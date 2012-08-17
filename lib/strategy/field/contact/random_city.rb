module DataAnon
  module Strategy
    module Field


      class RandomCity < GeojsonBase

        def initialize file_path
          @values = DataAnon::Utils::GeojsonParser.city(file_path)
        end

      end


    end
  end
end