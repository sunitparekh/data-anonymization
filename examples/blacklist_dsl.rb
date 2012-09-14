system "bundle exec ruby whitelist_dsl.rb"

require 'data-anonymization'

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'Chinook' do
  strategy DataAnon::Strategy::Blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  table 'Employee' do
    primary_key 'EmployeeId'
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

