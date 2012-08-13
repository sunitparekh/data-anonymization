require "spec_helper"

describe "End 2 End RDBMS Blacklist Acceptance Test using SQLite database" do

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

  before(:each) do
    system "rm -f tmp/customer.sqlite"
    system "mkdir -p tmp"
    source = {:adapter => 'sqlite3', :database => 'tmp/customer.sqlite'}
    ActiveRecord::Migration.verbose = false
    DataAnon::Utils::SourceDatabase.establish_connection source
    ActiveRecord::Base.establish_connection source
    CreateCustomer.migrate :up
  end


  it "should anonymize customer table record " do
    source = DataAnon::Utils::SourceTable.create 'customers', 'cust_id'
    cust = source.new :first_name => "Sunit", :last_name => "Parekh", :birth_date => Date.new(1977,7,8), :address => "F 501 Shanti Nagar", :state => "Maharastra", :zipcode => "411048", :phone => "9923700662", :email => "parekh.sunit@gmail.com"
    cust.cust_id = 1
    cust.save!

    database "Customer" do
      strategy DataAnon::Strategy::Blacklist
      source_db :adapter => 'sqlite3', :database => 'tmp/customer.sqlite'

      table 'customers' do
        primary_key 'cust_id'
        anonymize('email').using DataAnon::Strategy::Field::StringTemplate.new('test+#{row_number}@gmail.com')
      end
    end

    new_rec = source.find(1)
    new_rec['email'].should == 'test+1@gmail.com'

  end
end