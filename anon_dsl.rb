require 'data-anonymization'

source = {:adapter => 'sqlite3', :database => '/Users/sunitparekh/Projects/data-anonymization/sample-data/chinook.sqlite'}
destination = {:adapter => 'sqlite3', :database => '/Users/sunitparekh/Projects/data-anonymization/sample-data/chinook-empty.sqlite'}

database 'chinook', source, destination do

  table 'Genre' do |t|
    t.whitelist 'GenreId'
    t.anonymize 'Name'
    #t.anonymize 'FieldName1', 'FieldName2' using  Strategy::Default
  end

  table 'MediaType' do |t|
    t.whitelist 'MediaTypeId','Name'
  end

end

