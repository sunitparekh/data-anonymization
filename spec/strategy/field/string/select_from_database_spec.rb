require "spec_helper"

describe FieldStrategy::SelectFromDatabase do

  SelectFromDatabase = FieldStrategy::SelectFromDatabase
  let(:field) { DataAnon::Core::Field.new('name', 'Abcd', 1, nil) }
  let(:source)  { {:adapter => 'sqlite3', :database => 'sample-data/chinook.sqlite'} }

  describe 'more than one values in predefined list' do

    let(:anonymized_value) { SelectFromDatabase.new('MediaType','Name', source).anonymize(field) }

    it { anonymized_value.should_not be('Abcd') }
    it { anonymized_value.should_not be_empty }

  end

end