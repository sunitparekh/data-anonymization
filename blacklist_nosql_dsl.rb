require 'data-anonymization'

FS = DataAnon::Strategy::Field

DataAnon::Utils::Logging.logger.level = Logger::INFO

# DSL for NOSQL database, NOT IMPLEMENTED YET

database 'Chinook' do
  strategy DataAnon::Strategy::NoSQL::Blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  document 'User' do
    primary_key 'MediaTypeId'
    whitelist

    node 'address' do
      whitelist 'addrssline1', 'addressline2'
      anonymize
      anonymize 'pincode'

      node 'contacts' do
        anonymize('phone-number').using FS::RandomPhoneNumber.new
      end

      anonymize 'contacts/phone-number'

    end

    anonymize 'address/contacts/phone-number'

    anonymize('Name').using FS::StringTemplate.new('Media Type 100#{row_number}')
  end

end

