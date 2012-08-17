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
        primary_key 'cust_id'
        whitelist 'cust_id', 'address', 'zipcode'
        anonymize('first_name').using FieldStrategy::RandomFirstName.new
        anonymize('last_name').using FieldStrategy::RandomLastName.new
        anonymize('state').using FieldStrategy::SelectFromList.new(['Gujrat','Karnataka'])
        anonymize('phone').using FieldStrategy::RandomPhoneNumber.new
        anonymize('email').using FieldStrategy::StringTemplate.new('test+#{row_number}@gmail.com')
      end
    end

    DataAnon::Utils::DestinationDatabase.establish_connection dest_connection_spec
    dest_table = DataAnon::Utils::DestinationTable.create 'customers', ['cust_id']
    new_rec = dest_table.find(CustomerSample::SAMPLE_DATA[:cust_id])
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