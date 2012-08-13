require "spec_helper"

describe "String Utils" do

  it "should generate random string of given length" do
    string_util = DataAnon::Utils::StringUtils.new

    random_string = string_util.generate_random_string(10)
    random_string.length.should equal 10
  end
end