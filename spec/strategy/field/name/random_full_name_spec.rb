require "spec_helper"

describe FieldStrategy::RandomFullName do

  RandomFullName = FieldStrategy::RandomFullName

  describe 'anonymized name with just single name' do
    let(:field) {DataAnon::Core::Field.new('name','Fake',1,nil)}
    let(:anonymized_value) {RandomFullName.new().anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

  describe 'anonymized name should be the same as original' do
    let(:field) {DataAnon::Core::Field.new('name','Fake User',1,nil)}
    let(:anonymized_value) {RandomFullName.new().anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

  describe 'anonymized name should have same number of words as original' do
    let(:field) {DataAnon::Core::Field.new('name','Fake User Longer Name Test',1,nil)}
    let(:anonymized_value) {RandomFullName.new().anonymize(field)}

    it {anonymized_value.split(' ').size.should equal 5}
  end

end