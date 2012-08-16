module DataAnon
  module Strategy
    module Field
      class RandomZipcode

        def self.region_US
          self.new DataAnon::Utils::Resource.file('US_addresses.geojson')
        end

        def self.region_UK
          self.new DataAnon::Utils::Resource.file('UK_addresses.geojson')
        end

        def initialize file_path
          @zipcodes = DataAnon::Utils::GeojsonParser.zipcode(file_path)
        end

        def anonymize field
          @zipcodes[rand(@zipcodes.length)]
        end
      end
    end
  end
end