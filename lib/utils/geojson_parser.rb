require 'rgeo/geo_json'

module DataAnon
  module Utils
    class GeojsonParser


      def self.address file_path
        self.new(file_path).parse 'address'
      end

      def self.zipcode file_path
        self.new(file_path).parse 'postcode'
      end

      def self.province file_path
        self.new(file_path).parse 'province'
      end

      def self.city file_path
        self.new(file_path).parse 'city'
      end

      def self.country file_path
        self.new(file_path).parse 'country'
      end

      def initialize file_path
        @places = File.read(file_path).split(/\n/)
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