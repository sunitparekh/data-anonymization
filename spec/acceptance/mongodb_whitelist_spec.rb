require "spec_helper"
require 'mongo'

describe "End 2 End MongoDB Whitelist Acceptance Test" do

  before(:each) do
    Mongo::Client.new("mongodb://localhost/test").database.drop
    Mongo::Client.new("mongodb://localhost/dest").database.drop
    plans = [
        {
            "_id" => 1,
            "name" => "Free",
            "nick_names" => ["Name1","Name2"],
            "features" => [
                {
                    "max_storage" => 21474836480,
                    "type" => "AmazonS3",
                    "users" => {"max" => 1, "additional" => false}
                },
                {
                    "max_storage" => 21474836480,
                    "type" => "DropBox",
                    "users" => {"max" => 1, "additional" => false}
                }
            ],
            "term" => "month",
            "public_sharing" => false,
            "photo_sharing" => true,
            "created_at" => Time.new(2012, 6, 21, 13, 30, 0)
        },
        {
            "_id" => 2,
            "name" => "Team",
            "plan_aliases" => ["Business", "Paid"],
            "features" => [
                {
                    "max_storage" => 53687091200,
                    "type" => "AmazonS3",
                    "users" => {"max" => 5, "additional" => true}
                },
                {
                    "max_storage" => 53687091200,
                    "type" => "DropBox",
                    "users" => {"max" => 5, "additional" => true}
                }
            ],
            "term" => "month",
            "public_sharing" => true,
            "photo_sharing" => true,
            "created_at" => Time.new(2012, 8, 11, 13, 1, 0)
        }
    ]
    plans_coll =  Mongo::Client.new("mongodb://localhost/test").database.collection('plans')
    plans.each { |p| plans_coll.insert_one p }
  end

  it "should anonymize plans collection" do

    database 'dest' do
      strategy DataAnon::Strategy::MongoDB::Whitelist
      source_db :mongodb_uri => "mongodb://localhost/test", :database => 'test'
      destination_db :mongodb_uri => "mongodb://localhost/dest", :database => 'dest'

      collection 'plans' do
        whitelist '_id', 'name', 'term', 'created_at'
        anonymize('plan_aliases').using FieldStrategy::SelectFromList.new(%w(Free Team Business Paid))
        anonymize 'public_sharing', 'photo_sharing'

        collection 'features' do
          anonymize('max_storage').using FieldStrategy::SelectFromList.new([10737418240, 21474836480, 53687091200])
          whitelist 'type'

          document 'users' do
            anonymize 'max', 'additional'
          end
        end
      end

    end

    plans_coll = Mongo::Client.new("mongodb://localhost/dest").database.collection('plans')
    plans_coll.find.count.should be 2
    plan = plans_coll.find({ '_id' => 1}).to_a[0]

    plan['_id'].should == 1
    plan['name'].should == "Free"
    plan['nick_names'][0].should_not == "Name1"
    plan['nick_names'][1].should_not == "Name2"
    plan['term'].should == "month"
    plan['created_at'].should == Time.new(2012, 6, 21, 13, 30, 0)
    plan['plan_aliases'].should be_nil
    [true,false].should include(plan['public_sharing'])
    [true,false].should include(plan['photo_sharing'])
    plan['features'].length.should == 2
    feature1 = plan['features'][0]
    [10737418240, 21474836480, 53687091200].should include(feature1['max_storage'])
    feature1['type'].should == "AmazonS3"
    feature1['users']['max'].should be_kind_of(Fixnum)
    [true,false].should include(feature1['users']['additional'])


    plan = plans_coll.find({ '_id' => 2}).to_a[0]
    plan['plan_aliases'].length.should == 2
    ["Free", "Team", "Business", "Paid"].should include(plan['plan_aliases'][0])
    ["Free", "Team", "Business", "Paid"].should include(plan['plan_aliases'][1])
  end
end