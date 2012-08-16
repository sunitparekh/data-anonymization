# Data::Anonymization
Tool to create anonymized production data dump to use for PERF and other TEST environments.

## Getting started
Install gem using (use `pre` option to tryout edge version):

    $ gem install data-anonymization

Install required database adapter library for active record:

    $ gem install sqlite3

Create ruby program using data-anonymization DSL as following `my_dsl.rb`:

```ruby
require 'data-anonymization'

database 'DatabaseName' do
  strategy DataAnon::Strategy::Blacklist  # whitelist (default) or blacklist

  # database config as active record connection hash
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'

  # User -> table name
  table 'User' do
    # id, DateOfBirth, FirstName, LastName, UserName, Password -> table column names
    primary_key 'id'
    anonymize 'DateOfBirth','FirstName','LastName' # uses default anonymization based on data types
    anonymize('UserName').using FieldStrategy::StringTemplate.new('user#{row_number}')
    anonymize('Password') { |field| "password" }
  end

  ...

end
```

Run using:

    $ ruby my_dsl.rb

#### Share feedback
Please use Github [issues](https://github.com/sunitparekh/data-anonymization/issues) to share feedback, feature suggestions and report issues.

## What is data anonymization?

For almost all projects there is a need to have production data dump in order to run performance tests, rehearsal production releases and debugging production issues.
However, getting production data and using it is not feasible due to multiple reasons, one of them being that personal user data would be exposed. And thus arises the need for data anonymization.
This tool helps you to get anonymized production data dump using either Blacklist or Whitelist strategies.

## Anonymization Strategies

### Blacklist
This approach essentially leaves all fields unchanged with the exception of those specified by the user, which are scrambled/anonymized (hence the name blacklist).
Blacklist create a copy of prod database and chooses the fields to be anonymized like e.g. username, password, email, name, geo location etc. based on user specification Most of the fields had different rules e.g. password as always set to same value for all users, email needs to be valid.
The problem with this approach is that when new fields are added they will not be anonymized by default. Human error in omitting users personal data could be damaging.

```ruby
database 'DatabaseName' do
  strategy DataAnon::Strategy::Blacklist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'
  ...
end
```

### Whitelist
This approach, by default scrambles/anonymizes all fields except a list of fields which are allowed to copied as is. Hence the name whitelist.
By default all data needs to be anonymized. So from production database sanitizing the data record by record and insert anonymized data into destination database. Source database need only be readonly.
All fields would be anonymized using default anonymization strategies based on the datatype, unless an anonymization strategy is specified. For instance special strategies could be used for emails, passwords, usernames etc.
A list of whitelisted fields which implies that it's okay to copy the data as is and anonymization isn't required.
This way any new field will be anonymized by default and if we need them as is, add it to the whitelist explicitly. This prevents any human error and protects sensitive information.

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
anonymize('UserName').using FieldStrategy::LoremIpsum.new
```
```ruby
anonymize('UserName').using FieldStrategy::LoremIpsum.new("very large string....")
```
```ruby
anonymize('UserName').using FieldStrategy::LoremIpsum.new(File.read('my_file.txt'))
```

### RandomString
Generates random string of same length.
```ruby
anonymize('UserName').using FieldStrategy::RandomString.new
```

### StringTemplate
Simple string evaluation within [DataAnon::Core::Field](#dataanon-core-field) context. Can be used for email, username anonymization.
Make sure to put the string in 'single quote' else it will get evaluated inline.
```ruby
anonymize('UserName').using FieldStrategy::StringTemplate.new('user#{row_number}')
```
```ruby
anonymize('Email').using FieldStrategy::StringTemplate.new('valid.address+#{row_number}@gmail.com')
```
```ruby
anonymize('Email').using FieldStrategy::StringTemplate.new('useremail#{row_number}@mailinator.com')
```

### SelectFromList
Select randomly one of the values specified.
```ruby
anonymize('State').using FieldStrategy::SelectFromList.new(['New York','Georgia',...])
```
```ruby
anonymize('NameTitle').using FieldStrategy::SelectFromList.new(['Mr','Mrs','Dr',...])
```

### SelectFromFile
Similar to SelectFromList only difference is the list of values are picked up from file. Classical usage is like states field anonymization.
```ruby
anonymize('State').using FieldStrategy::SelectFromFile.new('states.txt')
```

### SelectFromDatabase
Similar to SelectFromList with difference is the list of values are collected from the database table using distinct column query.
```ruby
# values are collected using `select distinct state from customers` query
anonymize('State').using FieldStrategy::SelectFromDatabase.new('customers','state')
```

### RandomAddress
Generates address using the [geojson](http://www.geojson.org/geojson-spec.html) format file. The default US/UK file chooses randomly from 300 addresses.
The large data set can be downloaded from [here](http://www.infochimps.com/datasets/simplegeo-places-dump)
```ruby
anonymize('Address').using FieldStrategy::RandomAddress.region_US
```
```ruby
anonymize('Address').using FieldStrategy::RandomAddress.region_UK
```
```ruby
# get your own geo_json file and use it
anonymize('Address').using FieldStrategy::RandomAddress.new('my_geo_json.json')
```

### RandomZipcode
Similar to RandomAddress, generates zipcode using the [geojson](http://www.geojson.org/geojson-spec.html) format file. The default US/UK file chooses randomly from 300 addresses.
The large data set can be downloaded from [here](http://www.infochimps.com/datasets/simplegeo-places-dump)
```ruby
anonymize('Address').using FieldStrategy::RandomZipcode.region_US
```
```ruby
anonymize('Address').using FieldStrategy::RandomZipcode.region_UK
```
```ruby
# get your own geo_json file and use it
anonymize('Address').using FieldStrategy::RandomZipcode.new('my_geo_json.json')
```

### RandomPhoneNumber
Keeping the format same it changes each digit in the string with random digit.
```ruby
anonymize('PhoneNumber').using FieldStrategy::RandomPhoneNumber.new
```

### AnonymizeDateTime
Anonymizes each field(except year and seconds) within the natural range (e.g. hour between 1-24 and day within the month) based on true/false
input for that field. By default, all fields are anonymized.
```ruby
#anonymizes month and hour fields, leaving the day and minute fields untouched
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.new(true,false,true,false)
```

In addition to customizing which fields you want anonymized, there are some helper methods which allow for quick anonymization
```ruby
# anonymizes only the month field
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_month
# anonymizes only the day field
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_day
# anonymizes only the hour field
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_hour
# anonymizes only the minute field
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDateTime.only_minute
```

### AnonymizeTime
Exactly similar to the above DateTime strategy, except that the returned object is of type `Time`

### AnonymizeDate
Anonmizes day and month fields within natural range based on true/false input for that field. By defaut both fields are
anonymized
```ruby
# anonymizes month and leaves day unchanged
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.new(true,false)
```

In addition to customizing which fields you want anonymized, there are some helper methods which allow for quick anonymization
```ruby
# anonymizes only the month field
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.only_month
# anonymizes only the day field
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.only_day
```

### DateTimeDelta
Shifts data randomly within given range. Default shifts date within 10 days + or - and shifts time within 30 minutes.
```ruby
anonymize('DateOfBirth').using FieldStrategy::DateTimeDelta.new
```
```ruby
# shifts date within 20 days and time within 50 minutes
anonymize('DateOfBirth').using FieldStrategy::DateTimeDelta.new(20, 50)
```

### TimeDelta
Exactly similar to the above DateTime strategy, except that the returned object is of type `Time`

### DateDelta

Shifts date randomly within given delta range. Default shits date within 10 days + or -
```ruby
anonymize('DateOfBirth').using FieldStrategy::AnonymizeDate.new
```
```ruby
# shifts date within 25 days
anonymize('DateOfBirth').using FieldStrategy::DateDelta.new(25)
```

### RandomEmail
Generates email randomly using the given HOSTNAME and TLD.
By defaults generates hostname randomly along with email id.
```ruby
anonymize('Email').using FieldStrategy::RandomEmail.new('thoughtworks','com')
```

### GmailTemplate
Generates a valid unique gmail address by taking advantage of the gmail + strategy. Takes in a valid gmail username and
generates emails of the form username+<number>@gmail.com
```ruby
anonymize('Email').using FieldStrategy::GmailTemplate.new('username')
```

### RandomMailinatorEmail
Generates random email using mailinator hostname. e.g. <randomstring>@mailinator.com
```ruby
anonymize('Email').using FieldStrategy::RandomMailinatorEmail.new
```

### RandomUserName
Generates random user name of same length as original user name.
```ruby
anonymize('Username').using FieldStrategy::RandomUserName.new
```

### RandomFirstName
Randomly picks up first name from the predefined list in the file. Default [file](https://raw.github.com/sunitparekh/data-anonymization/master/resources/first_names.txt) is part of the gem.
File should contain first name on each line.
```ruby
anonymize('FirstName').using FieldStrategy::RandomFirstName.new
```
```ruby
anonymize('FirstName').using FieldStrategy::RandomFirstName.new('my_first_names.txt')
```

### RandomLastName
Randomly picks up last name from the predefined list in the file. Default [file](https://raw.github.com/sunitparekh/data-anonymization/master/resources/last_names.txt) is part of the gem.
File should contain last name on each line.
```ruby
anonymize('LastName').using FieldStrategy::RandomLastName.new
```
```ruby
anonymize('LastName').using FieldStrategy::RandomLastName.new('my_last_names.txt')
```

### RandomFullName
Generates full name using the RandomFirstName and RandomLastName strategies.
It also creates the s
```ruby
anonymize('FullName').using FieldStrategy::RandomFullName.new
```
```ruby
anonymize('FullName').using FieldStrategy::RandomLastName.new('my_first_names.txt', 'my_last_names.txt')
```

### RandomInteger
Generates random integer number between given two numbers. Default range is 0 to 100.
```ruby
anonymize('Age').using FieldStrategy::RandomInteger.new(18,70)
```

### RandomIntegerDelta
Shifts the current value randomly within given delta + and -. Default is 10
```ruby
anonymize('Age').using FieldStrategy::RandomIntegerDelta.new(2)
```

### RandomFloatDelta
Shifts the current value randomly within given delta + and -. Default is 10.0
```ruby
anonymize('Points').using FieldStrategy::RandomFloatDelta.new(2.5)
```

## Write you own field strategies
field parameter in following code is [DataAnon::Core::Field](#dataanon-core-field)

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
# Work in progress... TO BE COMPLETED
DEFAULT_STRATEGIES = {:string => FieldStrategy::LoremIpsum.new,
                      :integer => FieldStrategy::RandomIntegerDelta.new(5),
                      :float => FieldStrategy::RandomFloatDelta.new(5.0),
                      :datetime => FieldStrategy::DateTimeDelta.new,
                      :time => FieldStrategy::TimeDelta.new,
                      :date => FieldStrategy::DateDelta.new,
                      :boolean => FieldStrategy::RandomBoolean.new
}
```

Overriding default field strategies,

```ruby
database 'Chinook' do
  ...
  default_field_strategies  :string => FieldStrategy::RandomString.new
  ...
end
```

## Examples

1. [Whitelist](https://github.com/sunitparekh/data-anonymization/blob/master/whitelist_dsl.rb)
2. [Blacklist](https://github.com/sunitparekh/data-anonymization/blob/master/blacklist_dsl.rb)


## Logging

How do I switch off the progress bar?

```ruby
# add following line in your ruby file
ENV['show_progress'] = 'false'
```

`Logger` provides debug level messages including database queries of active record.

```ruby
DataAnon::Utils::Logging.logger.level = Logger::INFO
```

## Changelog

#### 0.2.0.pre

1. Added the progress bar using 'powerbar' gem. Which also shows the ETA for each table.
2. Added More strategies

#### 0.1.2 (August 14, 2012)

1. First initial release

## Roadmap

#### 0.2.0

1. Complete list of all the field strategies planned supporting all data types

#### 0.3.0

1. Run anonymization in parallel threads (performance enchantments)

#### 0.4.0

1. MongoDB anonymization support (NoSQL document based database support)

#### 0.5.0

1. MongoDB anonymization support (NoSQL document based database support)


## Want to contribute?

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

[MIT License](https://github.com/sunitparekh/data-anonymization/blob/master/LICENSE.txt)

## Credits

- [ThoughtWorks Inc](http://www.thoughtworks.com), for allowing us to build this tool and make it open source.
- [Birinder](https://twitter.com/birinder_) and [Panda](https://twitter.com/sarbashrestha) for reviewing the documentation.



