require 'data-anonymization'

FS = DataAnon::Strategy::Field

DataAnon::Utils::Logging.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger = DataAnon::Utils::Logging.logger
DataAnon::Utils::Logging.progress_logger = Logger.new(STDOUT)
DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'Chinook' do
  strategy DataAnon::Strategy::Blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  table 'Genre' do |t|
    t.primary_key 'GenreId'
    t.anonymize 'Name'
    #t.anonymize 'FieldName' do |data|
    #
    #end
  end

  table 'MediaType' do |t|
    t.primary_key 'MediaTypeId'
    t.anonymize('Name').using FS::StringTemplate.new('Media Type 100 #{row_number}')

  end

end

