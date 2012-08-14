require 'rgeo/geo_json'

module DataAnon
  module Utils
    class GeojsonParser

      DEFAULT_GEOJSON_FILE = 'US_addresses.geojson'

      def self.address file_path = nil
        self.new(file_path).parse 'address'
      end

      def self.zipcode file_path = nil
        self.new(file_path).parse 'postcode'
      end

      #def self.coordinates
      #  self.new
      #  result_list = []
      #  @places.each do |loc|
      #    geom = RGeo::GeoJSON.decode(loc, :json_parser => :json)
      #
      #  end
      #end

      def initialize file_path = nil
        file = file_path || DataAnon::Utils::Resource.file(DEFAULT_GEOJSON_FILE)
        @places = File.read(file).split(/\n/)
      end

      def parse property
        result_list = []
        @places.each do |loc|
          geom = RGeo::GeoJSON.decode(loc, :json_parser => :json)
          result_list.push(geom[property])
        end
        result_list
      end
    end
  end
end