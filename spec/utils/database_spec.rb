require "spec_helper"

describe "Utils" do

  it "should test the connection to source database" do
    Album = Utils::SourceTable.create :album
    Album.count.should > 0
  end

  it "should test the connection to destination database" do
    Album = Utils::DestinationTable.create :album
    Album.count.should == 0
  end

end