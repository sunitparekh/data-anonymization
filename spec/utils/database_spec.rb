require "spec_helper"

describe "Utils" do

  it "should test the connection to source database" do
    album = DataAnon::Utils::SourceTable.create "Album", "AlbumId"
    album.count.should > 0
    album.all.length > 0
  end

  it "should test the connection to destination database" do
    album = DataAnon::Utils::DestinationTable.create "Album", "AlbumId"
    album.count.should == 0
    album.all.length == 0

  end

end