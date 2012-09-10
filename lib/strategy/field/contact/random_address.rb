module DataAnon
  module Strategy
    module Field

      # Generates address using the [geojson](http://www.geojson.org/geojson-spec.html) format file. The default US/UK file chooses randomly from 300 addresses.
      # The large data set can be downloaded from [here](http://www.infochimps.com/datasets/simplegeo-places-dump)
      #
      #    !!!ruby
      #    anonymize('Address').using FieldStrategy::RandomAddress.region_US
      #
      #    !!!ruby
      #    anonymize('Address').using FieldStrategy::RandomAddress.region_UK
      #
      #    !!!ruby
      #    # get your own geo_json file and use it
      #    anonymize('Address').using FieldStrategy::RandomAddress.new('my_geo_json.json')

      class RandomAddress  < GeojsonBase

        def initialize file_path
          @values = DataAnon::Utils::GeojsonParser.address(file_path)
        end

      end


    end
  end
end