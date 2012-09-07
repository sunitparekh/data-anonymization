require "spec_helper"

describe FieldStrategy::SelectFromFile do

  SelectFromFile = FieldStrategy::SelectFromFile

  describe 'anonymized name must not be the same as provided name' do
    let(:field) {DataAnon::Core::Field.new('firstname','fakeFirstName',1,nil)}
    let(:anonymized_value) {SelectFromFile.new(DataAnon::Utils::Resource.file('first_names.txt')).anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

  describe 'anonymized multiple values' do
    let(:field) {DataAnon::Core::Field.new('firstname',['value1','value2'],1,nil)}
    let(:anonymized_values) {SelectFromFile.new(DataAnon::Utils::Resource.file('first_names.txt')).anonymize(field)}

    it {anonymized_values.length.should equal 2}
  end

end