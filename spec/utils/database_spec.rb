require 'spec_helper'

describe 'Utils' do

  before(:each) do
    source = {:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'}
    DataAnon::Utils::SourceDatabase.establish_connection source

    destination = {:adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'}
    DataAnon::Utils::DestinationDatabase.establish_connection destination
  end

  it 'should test the connection to source database' do
    album = DataAnon::Utils::SourceTable.create 'Album', ['AlbumId']
    album.count.should > 0
    album.all.length > 0
  end

  # This is a specific example encountered in the wild
  # Instead of creating a new class it references
  # ActiveSupport::Callbacks::Conditionals
  it 'creates a table for an in-scope constant' do
    conditionals = DataAnon::Utils::SourceTable.create 'Conditionals'
    conditionals.count.should == 0
    conditionals.all.length == 0
  end

  it 'should test the connection to destination database' do
    album = DataAnon::Utils::DestinationTable.create 'Album', ['AlbumId']
    album.count.should == 0
    album.all.length == 0
  end

end