system "rake empty_dest" # clean destination database on every call

require 'data-anonymization'

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'Chinook' do
  strategy DataAnon::Strategy::Whitelist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'
  destination_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  default_field_strategies :string => FieldStrategy::StringTemplate.new('Sunit #{row_number} Parekh')

  table 'Genre' do
    primary_key 'GenreId'
    whitelist 'GenreId'
    anonymize 'Name' do |field|
      field.value + " test"
    end
  end

  table 'MediaType' do
    primary_key 'MediaTypeId'
    anonymize('MediaTypeId') { |field| field.value } # same as whitelist
    anonymize('Name').using FieldStrategy::StringTemplate.new('Media Type #{row_number}')

  end

  table 'Employee' do
    primary_key 'EmployeeId'
    whitelist 'EmployeeId', 'ReportsTo', 'Title'
    anonymize('BirthDate').using FieldStrategy::DateTimeDelta.new(1, 1)
    anonymize('FirstName').using FieldStrategy::RandomFirstName.new
    anonymize('LastName').using FieldStrategy::RandomLastName.new
    anonymize('HireDate').using FieldStrategy::DateTimeDelta.new(2, 0)
    anonymize('Address').using FieldStrategy::RandomAddress.region_US
    anonymize('City').using FieldStrategy::RandomCity.region_US
    anonymize('State').using FieldStrategy::RandomProvince.region_US
    anonymize('PostalCode').using FieldStrategy::RandomZipcode.region_US
    anonymize('Country') {|field| "USA" }
    anonymize('Phone').using FieldStrategy::RandomPhoneNumber.new
    anonymize('Fax').using FieldStrategy::RandomPhoneNumber.new
    anonymize('Email').using FieldStrategy::StringTemplate.new('test+#{row_number}@gmail.com')
  end

  table 'Customer' do
    primary_key 'CustomerId'
    whitelist 'SupportRepId', 'Company'
    anonymize('Phone').using FieldStrategy::RandomPhoneNumber.new
    anonymize('FirstName').using FieldStrategy::RandomFirstName.new
    anonymize('LastName').using FieldStrategy::RandomLastName.new
    anonymize('Address').using FieldStrategy::RandomAddress.region_US
    anonymize('City').using FieldStrategy::RandomCity.region_US
    anonymize('State').using FieldStrategy::RandomProvince.region_US
    anonymize('PostalCode').using FieldStrategy::RandomZipcode.region_US
    anonymize('Country') {|field| "USA" }
    anonymize('Fax').using FieldStrategy::RandomPhoneNumber.new
    anonymize('Email').using FieldStrategy::StringTemplate.new('test+#{row_number}@gmail.com')
  end


end

