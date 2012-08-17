require "spec_helper"

describe "Geo Json Parser" do

  SAMPLE_DATA_FILE_PATH = DataAnon::Utils::Resource.project_home+'spec/resource/sample.geojson'

  describe "parser should return list of addresses when address method is called" do
    let(:result_list) {DataAnon::Utils::GeojsonParser.address(SAMPLE_DATA_FILE_PATH)}

    it {result_list.length.should be 1}
    it {result_list[0].should eq("333 Willoughby Ave")}
  end

  describe "parser should return list of zip codes when zipcode method is called" do
    let(:result_list) {DataAnon::Utils::GeojsonParser.zipcode(SAMPLE_DATA_FILE_PATH)}

    it {result_list.length.should be 1}
    it {result_list[0].should eq("99801")}

  end

  describe "parser should return list of province when province method is called" do
    let(:result_list) {DataAnon::Utils::GeojsonParser.province(SAMPLE_DATA_FILE_PATH)}

    it {result_list.length.should be 1}
    it {result_list[0].should eq("AK")}

  end

  describe "parser should return list of cities when city method is called" do
    let(:result_list) {DataAnon::Utils::GeojsonParser.city(SAMPLE_DATA_FILE_PATH)}

    it {result_list.length.should be 1}
    it {result_list[0].should eq("Juneau")}

  end

end