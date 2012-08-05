system "rake empty_dest"

require 'data-anonymization'

source = {:adapter => 'sqlite3', :database => '../sample-data/chinook.sqlite'}
destination = {:adapter => 'sqlite3', :database => '../sample-data/chinook-empty.sqlite'}

DataAnon::Utils::Logging.logger.level = Logger::INFO
ActiveRecord::Base.logger = DataAnon::Utils::Logging.logger

database 'Chinook' do
  strategy DataAnon::Strategy::Whitelist
  source source_conn
  destination destination_conn

  table 'Genre' do |t|
    t.primary_key 'GenreId'
    t.whitelist 'GenreId'
    t.anonymize 'Name'
    #t.anonymize 'FieldName1', 'FieldName2' using  Strategy::Default
    #t.anonymize 'FieldName' do |data|
    #
    #end
  end

  table 'MediaType' do |t|
    t.primary_key 'MediaTypeId'
    t.whitelist 'MediaTypeId','Name'
  end

end

