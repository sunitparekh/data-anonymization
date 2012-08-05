system "rake empty_dest" # clean destination database on every call

require 'data-anonymization'

FS = DataAnon::Strategy::Field

DataAnon::Utils::Logging.logger.level = Logger::DEBUG
ActiveRecord::Base.logger = DataAnon::Utils::Logging.logger

database 'Chinook' do
  strategy DataAnon::Strategy::Whitelist
  source_db :adapter => 'sqlite3', :database => '../sample-data/chinook.sqlite'
  destination_db :adapter => 'sqlite3', :database => '../sample-data/chinook-empty.sqlite'

  table 'Genre' do |t|
    t.primary_key 'GenreId'
    t.whitelist 'GenreId'
    t.anonymize 'Name'
    #t.anonymize 'FieldName' do |data|
    #
    #end
  end

  table 'MediaType' do |t|
    t.primary_key 'MediaTypeId'
    t.whitelist 'MediaTypeId'
    t.anonymize('Name').using FS::StringTemplate

  end

end

