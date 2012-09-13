require "spec_helper"

describe "String Utils" do

  it "should generate random string of given length" do
    DataAnon::Utils::RandomStringCharsOnly.generate(10).length.should equal 10
  end

  it "should generate random string only with characters" do
    DataAnon::Utils::RandomStringCharsOnly.generate(10).should match /^[a-z]{10}$/
  end
end