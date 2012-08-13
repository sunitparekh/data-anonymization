require "spec_helper"

describe "Number Utils" do

  it "should generate random int between provided range" do
    number_util = DataAnon::Utils::NumberUtils.new

    random_int = number_util.generate_random_int(5,10)
    random_int.should be_between(5,10)
  end
end