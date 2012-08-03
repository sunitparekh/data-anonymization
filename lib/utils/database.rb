require 'active_record'
require 'logger'

module Utils

  ActiveRecord::Base.logger = Logger.new(STDERR)
  ActiveRecord::Base.logger.level = Logger::DEBUG

  class SourceDatabase < ActiveRecord::Base
    establish_connection(:adapter => 'sqlite3', :database => '/Users/sunitparekh/Projects/data-anonymization/sample-data/chinook.sqlite')
    self.abstract_class = true
  end

  class DestinationDatabase < ActiveRecord::Base
    establish_connection(:adapter => 'sqlite3', :database => '/Users/sunitparekh/Projects/data-anonymization/sample-data/chinook-empty.sqlite')
    self.abstract_class = true
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