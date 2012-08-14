require "spec_helper"

describe "Geo Json Parser" do

  SAMPLE_DATA_FILE_PATH = DataAnon::Utils::Resource.project_home+'spec/resource/sample.geojson'

  describe "parser should return list of addresses when address method is called" do
    let(:result_list) {DataAnon::Utils::GeojsonParser.address(SAMPLE_DATA_FILE_PATH)}

    it {result_list.length.should be 1}
    it {result_list[0].should eq("R. Arandu, 205, 04562-030  Brooklyn Novo")}
  end

  describe "parser should return list of zip codes when zipcode method is called" do
    let(:result_list) {DataAnon::Utils::GeojsonParser.zipcode(SAMPLE_DATA_FILE_PATH)}

    it {result_list.length.should be 1}
    it {result_list[0].should eq("1110")}

  end

end