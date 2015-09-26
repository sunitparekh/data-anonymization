require "spec_helper"
require 'mongo'

describe "End 2 End MongoDB Blacklist Acceptance Test" do

  before(:each) do
    Mongo::Client.new("mongodb://localhost/test").database().drop()
    users = [
        {
            "_id" => 1,
            "USER_ID" => "sunitparekh",
            "date_of_birth" => Time.new(2012, 7, 14, 13, 1, 0),
            "email" => "parekh-sunit@mailinator.com",
            "password" => "TfqIK8Pd8GlbMDFZCX4l/5EtnOkfLCeynOL85tJQuxum&382knaflk@@",
            "failed_attempts" => 0,
            "first_name" => "Sunit",
            "last_name" => "Parekh",
            "password_reset_answer" => "manza",
            "password_reset_question" => "My new car modal?",
            "updated_at" => Time.new(2012, 8, 15, 13, 1, 0),
            "alternate_emails" => ["abc@test.com","abc2@test.com"]

        },
        {
            "_id" => 2,
            "USER_ID" => "anandagrawal",
            "date_of_birth" => Time.new(2011, 8, 11, 13, 1, 0),
            "email" => "anand-agrawal@mailinator.com",
            "password" => "Tz548O0RWusldVAWkwqfzO3jK/X4l/5EtnOkfLCeynOL85tJQuxum",
            "failed_attempts" => 0,
            "first_name" => "Anand",
            "last_name" => "Agrawal",
            "password_reset_answer" => "android",
            "password_reset_question" => "My phone?",
            "updated_at" => Time.new(2012, 2, 11, 13, 1, 0),
            "alternate_emails" => ["abc@test.com","abc2@test.com"]
        }
    ]
    users_coll = Mongo::Client.new("mongodb://localhost/test").database().collection('users')
    users.each { |p| users_coll.insert_one p }
  end

  it "should anonymize plans collection" do

    database 'test' do
      strategy DataAnon::Strategy::MongoDB::Blacklist
      source_db :mongodb_uri => "mongodb://localhost/test", :database => 'test'

      collection 'users' do
        anonymize('date_of_birth').using FieldStrategy::TimeDelta.new(5,30)
        anonymize('USER_ID').using FieldStrategy::StringTemplate.new('user-#{row_number}')
        anonymize('email').using FieldStrategy::RandomMailinatorEmail.new
        anonymize('password') { |field| "password" }
        anonymize('first_name').using FieldStrategy::RandomFirstName.new
        anonymize('last_name').using FieldStrategy::RandomLastName.new
        anonymize('alternate_emails').using FieldStrategy::AnonymizeArray.new(FieldStrategy::RandomMailinatorEmail.new)
      end

    end

    users_coll = Mongo::Client.new("mongodb://localhost/test").database().collection('users')
    users_coll.find.count.to_int.should be 2
    user = users_coll.find({'_id' => 1}).to_a[0]

    user['_id'].should == 1
    user['USER_ID'].should == "user-1"
    user['date_of_birth'].to_i.should_not == Time.new(2012, 7, 14, 13, 1, 0).to_i
    user['email'].should_not == "parekh-sunit@mailinator.com"
    user['password'].should == "password"
    user['failed_attempts'].should == 0
    user['first_name'].should_not be "Sunit"
    user['last_name'].should_not be "Parekh"
    user['password_reset_answer'].should == "manza"
    user['password_reset_question'].should == "My new car modal?"
    user['updated_at'].to_i.should == Time.new(2012, 8, 15, 13, 1, 0).to_i
    user['alternate_emails'].length.should == 2
    user['alternate_emails'][0].should_not == 'abc@test.com'
    user['alternate_emails'][1].should_not == 'abc2@test.com'


  end
end