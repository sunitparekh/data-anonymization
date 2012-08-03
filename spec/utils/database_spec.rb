require "spec_helper"

describe "Utils" do

  it "should test the connection to source database" do
    album = Utils::SourceTable.create "Album"
    album.count.should > 0
    album.all.length > 0
  end

  it "should test the connection to destination database" do
    album = Utils::DestinationTable.create "Album"
    album.count.should == 0
    album.all.length == 0

  end

end