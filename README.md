# Data::Anonymization
Tool to create anonymized production data dump to use for PREF and other TEST environments.

## Getting started
Install gem using:

    $ gem install data-anonymization

Create ruby program using data-anonymization DSL as following (my_dsl.rb):

```ruby
require 'data-anonymization'
DF = DataAnon::Strategy::Field

database 'DatabaseName' do
  strategy DataAnon::Strategy::Blacklist  # whitelist (default) or blacklist

  # database config as active record connection hash
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  table 'User' do
    primary_key 'id'
    anonymize 'DateOfBirth' # uses default anonymization based on data types
    anonymize('UserName').using DF::StringTemplate.new('user#{row_number}')
    anonymize 'Password' { |f| "password" }
  end

  ...

end
```

Run using:

    $ ruby my_dsl.rb

Read more to learn all the features of the tool...

## What is data anonymization?

For almost all the project it is almost a need to have production data dump to run performance tests, rehearsal production releases and debugging production issues.
However, getting production data and using it is not feasible due to multiple reasons and one of them is users personal data in database. And hence the need of data anonymization.
This tool helps you to get anonymized production data dump using either Blacklist or Whitelist strategies.

## Anonymization Strategies

### Blacklist
This approach is essentially to leave all fields unchanged with the exception of a few which are scrambled/anonymized (hence the name blacklist).
Blacklist create a copy of prod database and choose the fields to be anonymized like e.g. username, password, email, name, geo location etc. Most of the fields had different rules e.g. password as always set to same value for all user, email need to be valid email (we used gmail trick with +N appended to it).
Problem with this approach is, if new fields are added it will not be anonymized be default. Risk of user personal data passing through in future.

```ruby
database 'DatabaseName' do
  strategy DataAnon::Strategy::Blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'
  ...
end
```

### Whitelist
This approach is essentially to scramble/anonymize all fields except list of fields which are allowed to copy called as whitelist.
By default all data needs to be anonymized. So from production database sanitizing the data record by record and insert anonymized data into destination database. Source database is kind of readonly.
Have default anonymization rules based on data types. Have special rules for fields like username, password, email, name, geo location etc. And have list of whitelist fields means its okay to copy the data and doesn't need anonymization.
This way any new field will be default get anonymized and if we need them as is, add it to the whitelist explicitly.

```ruby
database 'DatabaseName' do
  strategy DataAnon::Strategy::Whitelist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'
  destination_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'
  ...
end
```

## Field Strategies

### LoremIpsum
Default anonymization strategy for string content. Uses default 'Lorem ipsum...' text or text supplied in strategy to generate same length string.

```ruby
anonymize('UserName').using DS::Field::LoremIpsum.new
```

```ruby
anonymize('UserName').using DS::Field::LoremIpsum.new("very large string....")
```

```ruby
anonymize('UserName').using DS::Field::LoremIpsum.new(File.read('my_file.txt'))
```

### RandomString
### StringTemplate
### DateTimeDelta
### RandomEmail
### RandomMailinatorEmail
### RandomUserName
### RandomFirstName
### RandomLastName
### RandomFullName
### RandomInt
### RandomIntegerDelta
### RandomFloatDelta

### Default Field Strategies

Overriding default field strategies,

```ruby
database 'Chinook' do
  default_field_strategies  :string => FS::LoremIpsum.new
  ...
end
```

## Examples

1. [Whitelist](https://github.com/sunitparekh/data-anonymization/blob/master/blacklist_dsl.rb)
2. [Blacklist](https://github.com/sunitparekh/data-anonymization/blob/master/whitelist_dsl.rb)


## Logging

1. Progress Logger
2. Logger

## Roadmap

1. Run anonymization in parallel (performance enchantments)
2. MongoDB anonymization support

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
