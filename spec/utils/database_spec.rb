require "spec_helper"

describe "Utils" do

  it "should test the connection to source database" do
    album = Utils::SourceTable.create :album
    album.count.should > 0
  end

  it "should test the connection to destination database" do
    album = Utils::DestinationTable.create :album
    album.count.should == 0
  end

end