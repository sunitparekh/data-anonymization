require "spec_helper"
require 'mongo'

describe "End 2 End MongoDB Blacklist Acceptance Test" do

  before(:each) do
    Mongo::Connection.from_uri("mongodb://localhost/test").drop_database('test')
    users = [
        {
            "_id" => 1,
            "user_id" => "sunitparekh",
            "date_of_birth" => Time.new(2012, 7, 14, 13, 1, 0),
            "email" => "parekh.sunit@gmail.com",
            "password" => "TfqIK8Pd8GlbMDFZCX4l/5EtnOkfLCeynOL85tJQuxum&382knaflk@@",
            "failed_attempts" => 0,
            "first_name" => "Sunit",
            "last_name" => "Parekh",
            "password_reset_answer" => "manza",
            "password_reset_question" => "My new car modal?",
            "updated_at" => Time.new(2012, 8, 15, 13, 1, 0)
        },
        {
            "_id" => 2,
            "user_id" => "anandagrawal",
            "date_of_birth" => Time.new(2011, 8, 11, 13, 1, 0),
            "email" => "anandagrawal84@gmail.com",
            "password" => "Tz548O0RWusldVAWkwqfzO3jK/X4l/5EtnOkfLCeynOL85tJQuxum",
            "failed_attempts" => 0,
            "first_name" => "Anand",
            "last_name" => "Agrawal",
            "password_reset_answer" => "android",
            "password_reset_question" => "My phone?",
            "updated_at" => Time.new(2012, 2, 11, 13, 1, 0)
        }
    ]
    users_coll = Mongo::Connection.from_uri("mongodb://localhost/dest",{:safe => true})['test']['users']
    users.each { |p| users_coll.save p }
  end

  it "should anonymize plans collection" do

    database 'test' do
      strategy DataAnon::Strategy::MongoDB::Blacklist
      source_db :mongodb_uri => "mongodb://localhost/test", :database => 'test', :options => {:safe => true}

      collection 'users' do
        anonymize('date_of_birth').using FieldStrategy::TimeDelta.new(5,30)
        anonymize('user_id').using FieldStrategy::StringTemplate.new('user-#{row_number}')
        anonymize('email').using FieldStrategy::RandomMailinatorEmail.new
        anonymize('password') { |field| "password" }
        anonymize('first_name').using FieldStrategy::RandomFirstName.new
        anonymize('last_name').using FieldStrategy::RandomLastName.new
      end

    end

    users_coll = Mongo::Connection.from_uri("mongodb://localhost/test")['test']['users']
    users_coll.count.should be 2
    user = users_coll.find_one({'_id' => 1})

    user['_id'].should == 1
    user['user_id'].should == "user-1"
    user['date_of_birth'].should_not == Time.new(2012, 7, 14, 13, 1, 0)
    user['email'].should_not == "parekh.sunit@gmail.com"
    user['password'].should == "password"
    user['failed_attempts'].should == 0
    user['first_name'].should_not be "Sunit"
    user['last_name'].should_not be "Parekh"
    user['password_reset_answer'].should == "manza"
    user['password_reset_question'].should == "My new car modal?"
    user['updated_at'].should == Time.new(2012, 8, 15, 13, 1, 0)


  end
end