module DataAnon
  module Strategy
    module Field

      # Similar to RandomAddress, generates city using the [geojson](http://www.geojson.org/geojson-spec.html) format file. The default US/UK file chooses randomly from 300 addresses.
      # The large data set can be downloaded from [here](http://www.infochimps.com/datasets/simplegeo-places-dump)
      #
      #    !!!ruby
      #    anonymize('City').using FieldStrategy::RandomCity.region_US
      #
      #    !!!ruby
      #    anonymize('City').using FieldStrategy::RandomCity.region_UK
      #
      #    !!!ruby
      #    # get your own geo_json file and use it
      #    anonymize('City').using FieldStrategy::RandomCity.new('my_geo_json.json')

      class RandomCity < GeojsonBase

        def initialize file_path
          @values = DataAnon::Utils::GeojsonParser.city(file_path)
        end

      end


    end
  end
end