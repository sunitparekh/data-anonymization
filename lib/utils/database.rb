require 'active_record'
require 'logger'

module Utils

  class SourceDatabase < ActiveRecord::Base
    establish_connection(:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite')
  end

  class DestinationDatabase < ActiveRecord::Base
    establish_connection(:adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite')
  end

  class BaseTable

    def self.create_table table_name, database
      Class.new(database) do
        self.table_name = table_name
      end
    end

  end

  class SourceTable < BaseTable

    def self.create table_name
      create_table table_name, SourceDatabase
    end

  end

  class DestinationTable < BaseTable

    def self.create table_name
      create_table table_name, DestinationDatabase
    end

  end

end