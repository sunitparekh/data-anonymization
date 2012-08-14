require "spec_helper"

describe FieldStrategy::SelectFromDatabase do

  before(:each) do
    source = {:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'}
    DataAnon::Utils::SourceDatabase.establish_connection source
  end

  SelectFromDatabase = FieldStrategy::SelectFromDatabase
  let(:field) { DataAnon::Core::Field.new('name', 'Abcd', 1, nil) }

  describe 'more than one values in predefined list' do

    let(:anonymized_value) { SelectFromDatabase.new('MediaType','Name').anonymize(field) }

    it { anonymized_value.should_not be('Abcd') }
    it { anonymized_value.should_not be_empty }

  end

end