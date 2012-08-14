module DataAnon
  module Strategy
    module Field
      class RandomZipcode

        def initialize file_path = nil
          @file_path = file_path
        end

        def self.region_US
          self.new DataAnon::Utils::Resource.file('US_addresses.geojson')
        end

        def self.region_UK
          self.new DataAnon::Utils::Resource.file('UK_addresses.geojson')
        end

        def anonymize field
          zipcode_list = DataAnon::Utils::GeojsonParser.zipcode(@file_path)
          zipcode_list[rand(zipcode_list.length)]
        end
      end
    end
  end
end