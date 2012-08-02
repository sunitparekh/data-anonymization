require "spec_helper"

describe "Utils" do

  it "should test the connection to source database" do
    album = Utils::BaseTable.create "Album", "AlbumId"
    album.establish_connection(:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite')
    album.count.should > 0
    album.all.length > 0
  end

  it "should test the connection to destination database" do
    album = Utils::BaseTable.create "Album", "AlbumId"
    album.establish_connection(:adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite')
    album.count.should == 0
  end

end