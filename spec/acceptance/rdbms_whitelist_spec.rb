require "spec_helper"

describe "End 2 End RDBMS Whitelist Acceptance Test using SQLite database" do

  source_connection_spec = {:adapter => 'sqlite3', :database => 'tmp/customer.sqlite'}
  dest_connection_spec = {:adapter => 'sqlite3', :database => 'tmp/customer-dest.sqlite'}

  before(:each) do
    CustomerSample.clean
    CustomerSample.create_schema source_connection_spec
    CustomerSample.insert_record source_connection_spec, CustomerSample::SAMPLE_DATA

    CustomerSample.create_schema dest_connection_spec
  end

  it "should anonymize customer table record " do

    database "Customer" do
      strategy DataAnon::Strategy::Whitelist
      source_db source_connection_spec
      destination_db dest_connection_spec

      table 'customers' do
        whitelist 'cust_id', 'address', 'zipcode', 'blog_url'
        anonymize('first_name').using FieldStrategy::RandomFirstName.new
        anonymize('last_name').using FieldStrategy::RandomLastName.new
        anonymize('state').using FieldStrategy::SelectFromList.new(['Gujrat','Karnataka'])
        anonymize('phone').using FieldStrategy::RandomPhoneNumber.new
        anonymize('email').using FieldStrategy::StringTemplate.new('test+#{row_number}@gmail.com')
        anonymize 'terms_n_condition', 'age', 'longitude'
        anonymize('latitude').using FieldStrategy::RandomFloatDelta.new(2.0)
        whitelist 'created_at','updated_at'
      end
    end

    DataAnon::Utils::DestinationDatabase.establish_connection dest_connection_spec
    dest_table = DataAnon::Utils::DestinationTable.create 'customers'
    new_rec = dest_table.where("cust_id" => CustomerSample::SAMPLE_DATA[:cust_id]).first
    new_rec.first_name.should_not be("Sunit")
    new_rec.last_name.should_not be("Parekh")
    new_rec.birth_date.should_not be(Date.new(1977,7,8))
    new_rec.address.should == 'F 501 Shanti Nagar'
    ['Gujrat','Karnataka'].should include(new_rec.state)
    new_rec.zipcode.should == '411048'
    new_rec.phone.should_not be "9923700662"
    new_rec.email.should == 'test+1@gmail.com'
    [true,false].should include(new_rec.terms_n_condition)
    new_rec.age.should be_between(0,100)
    new_rec.latitude.should be_between( 38.689060, 42.689060)
    new_rec.longitude.should be_between( -84.044636, -64.044636)
    new_rec.created_at.should == Time.new(2010,10,10)
    new_rec.updated_at.should == Time.new(2010,5,5)
  end

  context "when whitelisting attributes" do

    # This is intended to replicate what happens when
    #
    # config.active_record.whitelist_attributes = true
    #
    # is set in your application.

    default_active_authorizer = nil

    before(:each) do
      default_active_authorizer = ActiveRecord::Base.active_authorizers[:default]
      ActiveRecord::Base.active_authorizers[:default] = ActiveModel::MassAssignmentSecurity::WhiteList.new
    end

    after(:each) do
      ActiveRecord::Base.active_authorizers[:default] = default_active_authorizer
    end

    it "should copy the customer table data" do

      database "Customer" do
        strategy DataAnon::Strategy::Whitelist
        source_db source_connection_spec
        destination_db dest_connection_spec

        table 'customers' do
          whitelist 'cust_id', 'address', 'zipcode', 'blog_url'
          anonymize('first_name').using FieldStrategy::RandomFirstName.new
          anonymize('last_name').using FieldStrategy::RandomLastName.new
          anonymize('state').using FieldStrategy::SelectFromList.new(['Gujrat','Karnataka'])
          anonymize('phone').using FieldStrategy::RandomPhoneNumber.new
          anonymize('email').using FieldStrategy::StringTemplate.new('test+#{row_number}@gmail.com')
          anonymize 'terms_n_condition', 'age', 'longitude'
          anonymize('latitude').using FieldStrategy::RandomFloatDelta.new(2.0)
          whitelist 'created_at','updated_at'
        end
      end

      DataAnon::Utils::DestinationDatabase.establish_connection dest_connection_spec
      dest_table = DataAnon::Utils::DestinationTable.create 'customers'
      new_rec = dest_table.all.first
      new_rec.address.should == 'F 501 Shanti Nagar'
    end
  end
end
