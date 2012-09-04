# Data::Anonymization
Tool to create anonymized production data dump to use for PERF and other TEST environments.

[<img src="https://secure.travis-ci.org/sunitparekh/data-anonymization.png?branch=master">](http://travis-ci.org/sunitparekh/data-anonymization)
[<img src="https://gemnasium.com/sunitparekh/data-anonymization.png?travis">](https://gemnasium.com/sunitparekh/data-anonymization)
[<img src="https://codeclimate.com/badge.png">](https://codeclimate.com/github/sunitparekh/data-anonymization)

## Getting started

Install gem using:

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

  # User -> table name (case sensitive)
  table 'User' do
    # id, DateOfBirth, FirstName, LastName, UserName, Password -> table column names (case sensitive)
    primary_key 'id' # composite key is also supported
    anonymize 'DateOfBirth','FirstName','LastName' # uses default anonymization based on data types
    anonymize('UserName').using FieldStrategy::StringTemplate.new('user#{row_number}')
    anonymize('Password') { |field| "password" }
  end

  ...

end
```

Run using:

    $ ruby my_dsl.rb

## Examples

1. [Whitelist using Chinoook sample database](https://github.com/sunitparekh/data-anonymization/blob/master/whitelist_dsl.rb)
2. [Blacklist using Chinoook sample database](https://github.com/sunitparekh/data-anonymization/blob/master/blacklist_dsl.rb)
3. [Whitelist with composite primary key using DellStore sample database](https://github.com/sunitparekh/test-anonymization/blob/master/dell_whitelist.rb)
4. [Blacklist with composite primary key using DellStore sample database](https://github.com/sunitparekh/test-anonymization/blob/master/dell_blacklist.rb)

## Changelog

#### 0.3.0 (Sep 4, 2012)

Major changes:

1. Added support for Parallel table execution
2. Change in default String strategy from LoremIpsum to RandomString based on end user feedback.
3. Fixed issue with table column name 'type' as this is default name for STI in activerecord.

Please see the [Github 0.3.0 milestone page](https://github.com/sunitparekh/data-anonymization/issues?milestone=1&state=closed) for more details on changes/fixes in release 0.3.0

#### 0.2.0 (August 16, 2012)

1. Added the progress bar using 'powerbar' gem. Which also shows the ETA for each table.
2. Added More strategies
3. Fixed default anonymization strategies for boolean and integer values
4. Added support for composite primary key

#### 0.1.2 (August 14, 2012)

1. First initial release

## Roadmap

#### 0.4.0

1. MongoDB anonymization support (NoSQL document based database support)

#### 0.5.0

1. Generate DSL from database and build schema from source as part of Whitelist approach.

## Share feedback

Please use Github [issues](https://github.com/sunitparekh/data-anonymization/issues) to share feedback, feature suggestions and report issues.

## What is data anonymization?

For almost all projects there is a need for production data dump in order to run performance tests, rehearse production releases and debug production issues.
However, getting production data and using it is not feasible due to multiple reasons, primary being privacy concerns for user data. And thus the need for data anonymization.
This tool helps you to get anonymized production data dump using either Blacklist or Whitelist strategies.

## Anonymization Strategies

### Blacklist
This approach essentially leaves all fields unchanged with the exception of those specified by the user, which are scrambled/anonymized (hence the name blacklist).
For `Blacklist` create a copy of prod database and chooses the fields to be anonymized like e.g. username, password, email, name, geo location etc. based on user specification. Most of the fields have different rules e.g. password should be set to same value for all users, email needs to be valid.

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
By default all data needs to be anonymized. So from production database data is sanitized record by record and inserted as anonymized data into destination database. Source database needs to be readonly.
All fields would be anonymized using default anonymization strategy which is based on the datatype, unless a special anonymization strategy is specified. For instance special strategies could be used for emails, passwords, usernames etc.
A whitelisted field implies that it's okay to copy the data as is and anonymization isn't required.
This way any new field will be anonymized by default and if we need them as is, add it to the whitelist explicitly. This prevents any human error and protects sensitive information.

```ruby
database 'DatabaseName' do
  strategy DataAnon::Strategy::Whitelist
  source_db :adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'
  destination_db :adapter => 'sqlite3', :database => 'sample-data/chinook-empty.sqlite'
  ...
end
```

## Tips

1. In Whitelist approach make source database connection READONLY.
2. Change [default field strategies](#default-field-strategies) to avoid using same strategy again and again in your DSL.
3. To run anonymization in parallel at Table level, provided no FK constraint on tables use DataAnon::Parallel::Table strategy

## Running in Parallel
Currently provides capability of running anonymization in parallel at table level provided no FK constraints on tables.
It uses [Parallel gem](https://github.com/grosser/parallel) provided by Michael Grosser.
By default it starts multiple parallel ruby processes processing table one by one.
```ruby
database 'DellStore' do
  strategy DataAnon::Strategy::Whitelist
  execution_strategy DataAnon::Parallel::Table  # by default sequential table processing
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

### FormattedStringNumber
Keeping the format same it changes each digit in the string with random digit.

```ruby
anonymize('CreditCardNumber').using FieldStrategy::FormattedStringNumber.new
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

### RandomCity
Similar to RandomAddress, generates city using the [geojson](http://www.geojson.org/geojson-spec.html) format file. The default US/UK file chooses randomly from 300 addresses.
The large data set can be downloaded from [here](http://www.infochimps.com/datasets/simplegeo-places-dump)

```ruby
anonymize('City').using FieldStrategy::RandomCity.region_US
```

```ruby
anonymize('City').using FieldStrategy::RandomCity.region_UK
```

```ruby
# get your own geo_json file and use it
anonymize('City').using FieldStrategy::RandomCity.new('my_geo_json.json')
```

### RandomProvince
Similar to RandomAddress, generates province using the [geojson](http://www.geojson.org/geojson-spec.html) format file. The default US/UK file chooses randomly from 300 addresses.
The large data set can be downloaded from [here](http://www.infochimps.com/datasets/simplegeo-places-dump)

```ruby
anonymize('Province').using FieldStrategy::RandomProvince.region_US
```

```ruby
anonymize('Province').using FieldStrategy::RandomProvince.region_UK
```

```ruby
# get your own geo_json file and use it
anonymize('Province').using FieldStrategy::RandomProvince.new('my_geo_json.json')
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

### RandomFloat
Generates random float number between given two numbers. Default range is 0.0 to 100.0

```ruby
anonymize('points').using FieldStrategy::RandomInteger.new(3.0,5.0)
```

### RandomFloatDelta
Shifts the current value randomly within given delta + and -. Default is 10.0

```ruby
anonymize('points').using FieldStrategy::RandomFloatDelta.new(2.5)
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
DEFAULT_STRATEGIES = {:string => FieldStrategy::RandomString.new,
                      :fixnum => FieldStrategy::RandomIntegerDelta.new(5),
                      :bignum => FieldStrategy::RandomIntegerDelta.new(5000),
                      :float => FieldStrategy::RandomFloatDelta.new(5.0),
                      :bigdecimal => FieldStrategy::RandomBigDecimalDelta.new(500.0),
                      :datetime => FieldStrategy::DateTimeDelta.new,
                      :time => FieldStrategy::TimeDelta.new,
                      :date => FieldStrategy::DateDelta.new,
                      :trueclass => FieldStrategy::RandomBoolean.new,
                      :falseclass => FieldStrategy::RandomBoolean.new
}
```

Overriding default field strategies & can be used to provide default strategy for missing data type.

```ruby
database 'Chinook' do
  ...
  default_field_strategies  :string => FieldStrategy::RandomString.new
  ...
end
```

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
- [Panda](https://twitter.com/sarbashrestha) for reviewing the documentation.
- [Dan Abel](http://www.linkedin.com/pub/dan-abel/0/61b/9b0) for introducing me to Blacklist and Whitelist approach for data anonymization.
- [Chirga Doshi](https://twitter.com/chiragsdoshi) for encouraging me to get this done.
- [Aditya Karle](https://twitter.com/adityakarle) for the Logo. (Coming Soon...)


