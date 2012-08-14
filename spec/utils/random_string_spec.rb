require "spec_helper"

describe "String Utils" do

  it "should generate random string of given length" do
    DataAnon::Utils::RandomString.generate(10).length.should equal 10
  end
end