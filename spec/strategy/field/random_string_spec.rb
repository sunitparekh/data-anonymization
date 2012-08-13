require "spec_helper"

describe DataAnon::Strategy::Field::RandomString do

  RandomString = DataAnon::Strategy::Field::RandomString

  describe 'anonymized string must not be the same as original string' do
    let(:field) {DataAnon::Core::Field.new('string_field','fakeString',1,nil)}
    let(:anonymized_string) {RandomString.new.anonymize(field)}

    it {anonymized_string.should_not equal field.value}
    it {anonymized_string.length.should equal field.value.length}
  end

  describe 'anonymized name should have same number of words as original' do

    let(:field) {DataAnon::Core::Field.new('string_field','Fake Longer String Test',1,nil)}
    let(:anonymized_string) {RandomString.new.anonymize(field)}

    it {anonymized_string.split(' ').size.should equal field.value.split(' ').size}

  end
end