module DataAnon
  module Strategy
    module Field
      class GeojsonBase

        def self.region_US
          self.new DataAnon::Utils::Resource.file('US_addresses.geojson')
        end

        def self.region_UK
          self.new DataAnon::Utils::Resource.file('UK_addresses.geojson')
        end

        def initialize file_path
          raise "Load and set the @values member variable in constructor"
        end

        def anonymize field
          @values.sample
        end
      end
    end
  end
end