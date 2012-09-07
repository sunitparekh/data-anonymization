system "bundle exec ruby whitelist_dsl.rb"

require 'data-anonymization'

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'Chinook' do
  strategy DataAnon::Strategy::Blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  table 'MediaType' do
    primary_key 'MediaTypeId'
    anonymize('Name').using FieldStrategy::StringTemplate.new('Media Type 100#{row_number}')
  end

end

