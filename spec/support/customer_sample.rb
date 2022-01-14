class CustomerSample

  class CreateCustomer < ActiveRecord::Migration[7.0]
    def up
      create_table :customers, :id => false, :force => true do |t|
        t.integer :cust_id, :primary => true
        t.string :first_name
        t.string :last_name
        t.date :birth_date
        t.string :address
        t.string :state
        t.string :zipcode
        t.string :phone
        t.string :email
        t.string :blog_url
        t.boolean :terms_n_condition
        t.integer :age
        t.float :latitude
        t.float :longitude

        t.timestamps null: false
      end
    end
  end

  def self.clean
    system "rm -f tmp/*.sqlite"
    system "mkdir -p tmp"
  end

  def self.create_schema connection_spec
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Base.establish_connection connection_spec
    CreateCustomer.migrate :up
  end

  SAMPLE_DATA = [
  {
    :cust_id => 100, :first_name => "Sunit", :last_name => "Parekh",
    :birth_date => Date.new(1977,7,8), :address => "F 501 Shanti Nagar",
    :state => "Maharastra", :zipcode => "411048", :phone => "9923700662",
    :email => "parekh.sunit@gmail.com", :terms_n_condition => true,
    :age => 34, :longitude => -74.044636, :latitude => +40.689060,
    :created_at => Time.new(2010,10,10), :updated_at => Time.new(2010,5,5)
  },
  {
    :cust_id => 101, :first_name => "Rohit", :last_name => "Parekh",
    :birth_date => Date.new(1977,7,8), :address => "F 501 Shanti Nagar",
    :state => "Maharastra", :zipcode => "411048", :phone => "9923700662",
    :email => "parekh.sunit@gmail.com", :terms_n_condition => true,
    :age => 34, :longitude => -74.044636, :latitude => +40.689060,
    :created_at => Time.now, :updated_at => Time.now
  }
  ]

  def self.insert_record connection_spec, data_hash = SAMPLE_DATA[0]
    DataAnon::Utils::TempDatabase.establish_connection connection_spec
    source = DataAnon::Utils::BaseTable.create_table DataAnon::Utils::TempDatabase, 'customers', 'cust_id'
    cust = source.new data_hash
    cust.cust_id = data_hash[:cust_id]
    cust.save!
  end

  def self.insert_records connection_spec, data_hash = SAMPLE_DATA
    DataAnon::Utils::TempDatabase.establish_connection connection_spec
    source = DataAnon::Utils::BaseTable.create_table DataAnon::Utils::TempDatabase, 'customers', 'cust_id'
    data_hash.each do |data_row|
      cust = source.new data_row
      cust.cust_id = data_row[:cust_id]
      cust.save!
    end
  end
end
