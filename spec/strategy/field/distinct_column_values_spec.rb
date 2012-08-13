require "spec_helper"

describe DataAnon::Strategy::Field::DistinctColumnValues do

  before(:each) do
    source = {:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'}
    DataAnon::Utils::SourceDatabase.establish_connection source
  end

  DistinctColumnValues = DataAnon::Strategy::Field::DistinctColumnValues
  let(:field) { DataAnon::Core::Field.new('name', 'Abcd', 1, nil) }

  describe 'more than one values in predefined list' do

    let(:anonymized_value) { DistinctColumnValues.new('MediaType','Name').anonymize(field) }

    it { anonymized_value.should_not be('Abcd') }
    it { anonymized_value.should_not be_empty }

  end

end