require "spec_helper"

describe "Template Helper" do

  it "should return a correctly formatted string based on input connection hash for source" do
    connection_hash = {:adapter => "test_adapter", :port => 5000}
    DataAnon::Utils::TemplateHelper.source_connection_specs(connection_hash).should eq(":adapter => 'test_adapter', :port => 5000")
  end

  it "should return a correctly formatted string based on input connection hash for destination" do
    connection_hash = {:adapter => "test_adapter", :port => 5000}
    DataAnon::Utils::TemplateHelper.destination_connection_specs(connection_hash).should eq(":adapter => '<enter_value>', :port => '<enter_value>'")
  end
end