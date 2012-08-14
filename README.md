# Data::Anonymization
Tool to create anonymized production data dump to use for PREF and other TEST environments.

## Getting started
Install gem using:

    $ gem install data-anonymization

Create ruby program using data-anonymization DSL as following `my_dsl.rb`:

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
    anonymize('Password') { |field| "password" }
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

## DataAnon::Core::Field
The object that gets passed along with the field strategies.

has following attribute accessor

- `name` current field/column name
- `value` current field/column value
- `row_number` current row number
- `ar_record` active record of the current row under processing

## Field Strategies

### LoremIpsum
Default anonymization strategy for `string` content. Uses default 'Lorem ipsum...' text or text supplied in strategy to generate same length string.

```ruby
anonymize('UserName').using DataAnon::Strategy::Field::LoremIpsum.new
```
```ruby
anonymize('UserName').using DataAnon::Strategy::Field::LoremIpsum.new("very large string....")
```
```ruby
anonymize('UserName').using DataAnon::Strategy::Field::LoremIpsum.new(File.read('my_file.txt'))
```

### RandomString
Generates random string of same length.
```ruby
anonymize('UserName').using DataAnon::Strategy::Field::RandomString.new
```

### StringTemplate
Simple string evaluation with [DataAnon::Core::Field](#dataanon-core-field) in scope. Can be used for email, username anonymization.
Make sure to put the string in 'single quote' else it will get evaluated inline.
```ruby
anonymize('UserName').using DataAnon::Strategy::Field::StringTemplate.new('user#{row_number}')
```
```ruby
anonymize('Email').using DataAnon::Strategy::Field::StringTemplate.new('valid.address+#{row_number}@gmail.com')
```
```ruby
anonymize('Email').using DataAnon::Strategy::Field::StringTemplate.new('useremail#{row_number}@mailinator.com')
```

### DateTimeDelta
Shifts data randomly within given range. Default shifts date within 10 days + or - and shifts time within 30 minutes.
```ruby
anonymize('DateOfBirth').using DataAnon::Strategy::Field::DateTimeDelta.new
```
```ruby
# shifts date within 20 days and time within 50 minutes
anonymize('DateOfBirth').using DataAnon::Strategy::Field::DateTimeDelta.new(20, 50)
```

### RandomEmail
Generates email randomly using the given HOSTNAME and TLD.
By defaults generates hostname randomly along with email id.
```ruby
anonymize('DateOfBirth').using DataAnon::Strategy::Field::RandomEmail.new('thoughtworks','com')
```

### RandomMailinatorEmail
Generates random email using mailinator hostname. e.g. <randomstring>@mailinator.com
```ruby
anonymize('DateOfBirth').using DataAnon::Strategy::Field::RandomMailinatorEmail.new
```

### RandomUserName
### RandomFirstName
### RandomLastName
### RandomFullName
### RandomInt
### RandomIntegerDelta
### RandomFloatDelta

- - -



- - -

## Write you own field strategies

```ruby
class MyFieldStrategy

    # method anonymize is what required
    def anonymize field
      # write your code here
    end

end
```

write your own anonymous field strategies within DSL,

```ruby
  table 'User' do
    anonymize('Password') { |field| "password" }
    anonymize('email') do |field|
        "test+#{field.row_number}@gmail.com"
    end
  end
```


## Default field strategies

```ruby
# Work in progress...
DEFAULT_STRATEGIES = {:string => FS::LoremIpsum.new,
                      :integer => FS::RandomInt.new(18,70),
                      :datetime => FS::DateTimeDelta.new,
                      :boolean => FS::RandomBoolean.new
}
```

Overriding default field strategies,

```ruby
database 'Chinook' do
  ...
  default_field_strategies  :string => DataAnon::Strategy::Field::RandomString.new
  ...
end
```

## Examples

1. [Whitelist](https://github.com/sunitparekh/data-anonymization/blob/master/whitelist_dsl.rb)
2. [Blacklist](https://github.com/sunitparekh/data-anonymization/blob/master/blacklist_dsl.rb)


## Logging

`Progress Logger` provides progress of anonymization execution table by table.

```ruby
DataAnon::Utils::Logging.progress_logger.level = Logger::WARN
```

`Logger` provides debug level messages including database queries of active record.

```ruby
DataAnon::Utils::Logging.logger.level = Logger::INFO
```


## What's plan ahead?

1. Run anonymization in parallel threads (performance enchantments)
2. MongoDB anonymization support (NoSQL document based database support)

## Want to contribute?

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

[MIT License](https://github.com/sunitparekh/data-anonymization/blob/master/LICENSE.txt)

## Credits


