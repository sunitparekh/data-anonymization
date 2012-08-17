module DataAnon
  module Strategy
    module Field


      class RandomProvince < GeojsonBase

        def initialize file_path
          @values = DataAnon::Utils::GeojsonParser.province(file_path)
        end

      end


    end
  end
end