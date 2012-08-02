require 'data-anonymization'

source = {:adapter => 'sqlite3', :database => '/Users/sunitparekh/Projects/data-anonymization/sample-data/chinook.sqlite'}
destination = {:adapter => 'sqlite3', :database => '/Users/sunitparekh/Projects/data-anonymization/sample-data/chinook-empty.sqlite'}

database 'chinook', source, destination do

  table 'Genre' do |t|
    t.primary 'GenreId'
    t.whitelist 'GenreId'
    t.default_anonymize 'Name'
  end

  table 'MediaType' do |t|
    t.primary 'MediaTypeId'
    t.whitelist 'MediaTypeId','Name'
  end

end

