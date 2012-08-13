require "spec_helper"

describe "Utils" do

  before(:each) do
    source = {:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'}
    DataAnon::Utils::SourceDatabase.establish_connection source

    destination = {:adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'}
    DataAnon::Utils::DestinationDatabase.establish_connection destination
  end

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