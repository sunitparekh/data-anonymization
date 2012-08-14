require "spec_helper"

describe "End 2 End RDBMS Blacklist Acceptance Test using SQLite database" do
  connection_spec = {:adapter => 'sqlite3', :database => 'tmp/customer.sqlite'}

  before(:each) do
    CustomerSample.clean
    CustomerSample.create_schema connection_spec
    CustomerSample.insert_record connection_spec, CustomerSample::SAMPLE_DATA
  end

  it "should anonymize customer table record " do

    database "Customer" do
      strategy DataAnon::Strategy::Blacklist
      source_db connection_spec

      table 'customers' do
        primary_key 'cust_id'
        anonymize('email').using FieldStrategy::StringTemplate.new('test+#{row_number}@gmail.com')
      end
    end

    DataAnon::Utils::SourceDatabase.establish_connection connection_spec
    source = DataAnon::Utils::SourceTable.create 'customers', 'cust_id'
    new_rec = source.find(CustomerSample::SAMPLE_DATA[:cust_id])
    new_rec['email'].should == 'test+1@gmail.com'

  end
end