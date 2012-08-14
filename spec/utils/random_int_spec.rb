require "spec_helper"

describe "Number Utils" do

  it "should generate random int between provided range" do
    random_int = DataAnon::Utils::RandomInt.generate(5,10)
    random_int.should be_between(5,10)
  end
end