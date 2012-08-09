system "rake empty_dest" # clean destination database on every call

require 'data-anonymization'

FS = DataAnon::Strategy::Field

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'Chinook' do
  strategy DataAnon::Strategy::Whitelist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'
  destination_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  default_field_strategies  :string => FS::StringTemplate.new('Sunit #{row_number} Parekh')

  table 'Genre' do
    primary_key 'GenreId'
    whitelist 'GenreId'
    #anonymize('Name') { |field| "sunit@gmail.com" }
    #anonymize 'FieldName' do |field|
    #
    #end
  end

  table 'MediaType' do
    primary_key 'MediaTypeId'
    whitelist 'MediaTypeId'
    anonymize('Name').using FS::StringTemplate.new('Media Type #{row_number}')

  end

  table 'Employee' do
    primary_key 'EmployeeId'
    whitelist 'EmployeeId'
    anonymize('BirthDate').using FS::DateTimeDelta.new(1,1)
  end

end

