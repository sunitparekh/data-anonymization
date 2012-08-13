require "spec_helper"

describe DataAnon::Strategy::Field::RandomFullName do

  RandomFullName = DataAnon::Strategy::Field::RandomFullName
  let(:field) {DataAnon::Core::Field.new('name','Fake User',1,nil)}

  describe 'anonymized name should be the same as original' do

    let(:anonymized_name) {RandomFullName.new().anonymize(field)}

    it {anonymized_name.should_not equal field.value}
  end

  describe 'anonymized name should have same number of words as original' do

    let(:field) {DataAnon::Core::Field.new('name','Fake User Longer Name Test',1,nil)}
    let(:anonymized_name) {RandomFullName.new().anonymize(field)}

    it {anonymized_name.split(' ').size.should equal field.value.split(' ').size}
  end

end