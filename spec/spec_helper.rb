require 'rspec'
require "pry"
require 'data-anonymization'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


source = {:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'}
destination = {:adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'}

DataAnon::Utils::SourceDatabase.establish_connection source
DataAnon::Utils::DestinationDatabase.establish_connection destination

DataAnon::Utils::Logging.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger = DataAnon::Utils::Logging.logger
DataAnon::Utils::Logging.progress_logger = Logger.new(STDOUT)
DataAnon::Utils::Logging.logger.level = Logger::INFO


RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with 'rspec-mocks'

  config.before(:suite) do
  end

  config.before(:each) do
  end

  config.after(:suite) do
  end
end



