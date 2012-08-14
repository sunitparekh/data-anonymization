module DataAnon
  module Strategy
    module Field
      class RandomAddress

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
          address_list = DataAnon::Utils::GeojsonParser.address(@file_path)
          address_list[rand(address_list.length)]
        end
      end
    end
  end
end