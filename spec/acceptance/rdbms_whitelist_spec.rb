require "spec_helper"

describe "End 2 End RDBMS Whitelist Acceptance Test using SQLite database" do

  class CreateCustomer < ActiveRecord::Migration
    def up
      create_table :customers, { :id => false } do |t|
        t.integer :cust_id, :primary => true
        t.string :first_name
        t.string :last_name
        t.date :birth_date
        t.string :address
        t.string :state
        t.string :zipcode
        t.string :phone
        t.string :email
      end
    end
  end

  source_connection_spec = {:adapter => 'sqlite3', :database => 'tmp/customer.sqlite'}
  dest_connection_spec = {:adapter => 'sqlite3', :database => 'tmp/customer-dest.sqlite'}

  before(:each) do
    system "rm -f tmp/*.sqlite"
    system "mkdir -p tmp"
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Base.establish_connection source_connection_spec
    CreateCustomer.migrate :up
    ActiveRecord::Base.establish_connection dest_connection_spec
    CreateCustomer.migrate :up
  end


  it "should anonymize customer table record " do
    DataAnon::Utils::SourceDatabase.establish_connection source_connection_spec
    source = DataAnon::Utils::SourceTable.create 'customers', 'cust_id'
    cust = source.new :first_name => "Sunit", :last_name => "Parekh", :birth_date => Date.new(1977,7,8),
                      :address => "F 501 Shanti Nagar", :state => "Maharastra", :zipcode => "411048",
                      :phone => "9923700662", :email => "parekh.sunit@gmail.com"
    cust.cust_id = 1
    cust.save!

    DF = DataAnon::Strategy::Field

    database "Customer" do
      strategy DataAnon::Strategy::Whitelist
      source_db source_connection_spec
      destination_db dest_connection_spec

      table 'customers' do
        primary_key 'cust_id'
        whitelist 'cust_id', 'address', 'zipcode'
        anonymize('first_name').using DF::RandomFirstName.new
        anonymize('last_name').using DF::RandomLastName.new
        anonymize('state').using DF::RandomSelection.new(['Gujrat','Karnataka'])
        anonymize('phone').using DF::RandomPhoneNumber.new
        anonymize('email').using DF::StringTemplate.new('test+#{row_number}@gmail.com')
      end
    end

    DataAnon::Utils::DestinationDatabase.establish_connection dest_connection_spec
    dest_table = DataAnon::Utils::DestinationTable.create 'customers', 'cust_id'
    new_rec = dest_table.find(1)
    new_rec.first_name.should_not be("Sunit")
    new_rec.last_name.should_not be("Parekh")
    new_rec.birth_date.should_not be(Date.new(1977,7,8))
    new_rec.address.should == 'F 501 Shanti Nagar'
    ['Gujrat','Karnataka'].should include(new_rec.state)
    new_rec.zipcode.should == '411048'
    new_rec.phone.should_not be "9923700662"
    new_rec.email.should == 'test+1@gmail.com'


  end
end