require 'data-anonymization'

require 'mongo'
require 'json'
Mongo::Connection.from_uri("mongodb://localhost/test").drop_database('test')
Mongo::Connection.from_uri("mongodb://localhost/dest").drop_database('dest')

system "mongoimport -d test --drop -c users --jsonArray ./sample-data/mongo/users.json"
system "mongoimport -d test --drop -c plans --jsonArray ./sample-data/mongo/plans.json"

DataAnon::Utils::Logging.logger.level = Logger::INFO

database 'test' do
  strategy DataAnon::Strategy::MongoDB::Whitelist
  source_db :mongodb_uri => "mongodb://localhost/test", :database => 'test'
  destination_db :mongodb_uri => "mongodb://localhost/dest", :database => 'dest'

  collection 'users' do
    whitelist '_id','failed_attempts','updated_at'
    anonymize('date_of_birth').using FieldStrategy::TimeDelta.new(5,30)
    anonymize('user_id').using FieldStrategy::StringTemplate.new('user-#{row_number}')
    anonymize('email').using FieldStrategy::RandomMailinatorEmail.new
    anonymize('password') { |field| "password" }
    anonymize('first_name').using FieldStrategy::RandomFirstName.new
    anonymize('last_name').using FieldStrategy::RandomLastName.new
    anonymize 'password_reset_answer','password_reset_question'
  end

  collection 'plans' do
    whitelist '_id', 'name','term', 'created_at'
    anonymize('plan_aliases').using FieldStrategy::SelectFromList.new(["Free","Team","Business","Paid"])
    anonymize 'public_sharing','photo_sharing'

    collection 'features' do
      anonymize('max_storage').using FieldStrategy::SelectFromList.new([10737418240,21474836480,53687091200])
      whitelist 'type'

      document 'users' do
        anonymize 'max', 'additional'
      end
    end

  end

end

