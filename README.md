# Data::Anonymization

# Getting started

Install gem using:

    $ gem install data-anonymization

Create ruby program using data-anonymization DSL as following:

```ruby
require 'data-anonymization'

database 'DatabaseName' do
  strategy DataAnon::Strategy::Blacklist  # strategy to use whitelist or blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite' # active record connection hash

  table 'TableName' do
    primary_key 'FieldNamePK'
    whitelist 'FieldNameA','FieldNameB'
    anonymize 'FieldName1','FieldName2' # uses default anonymization based on data types
    anonymize('FieldName3').using FS::StringTemplate.new('Media Type 100#{row_number}')
    ...
  end

  ...

end
```

Run using:

    $ ruby my_dsl.rb

Read more to learn all the features of the tool...

# What is data anonymization?

For almost all the project it is almost a need to have production data dump to run performance tests, rehearsal production releases and debugging production issues.
However, getting production data and using it is not feasible due to multiple reasons and one of them is users personal data in database. And hence the need of data anonymization.
This tool helps you to get anonymized production data dump using either Blacklist or Whitelist strategies.

## Blacklist

## Whitelist




## Installation

Add this line to your application's Gemfile:

    gem 'data-anonymization'

And then execute:

    $ bundle

Or

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
