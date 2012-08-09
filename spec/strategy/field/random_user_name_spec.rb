require "spec_helper"

describe DataAnon::Strategy::Field::RandomUserName do

  RandomUserName = DataAnon::Strategy::Field::RandomUserName
  let(:field) {DataAnon::Core::Field.new('username','fakeUserName',1,nil)}

  describe 'anonymized user name should not be the same as original user name' do
    let(:anonymized_username) {RandomUserName.new(5,10).anonymize(field)}

    it {anonymized_username.should_not equal field.value}
  end

  describe 'anonymized user name length should be within specified range' do
    let(:anonymized_username) {RandomUserName.new(5,10).anonymize(field)}

    it {anonymized_username.length.should be_between(5,10)}
  end

  describe 'anonymized user name should contain only alphanumeric characters' do
    let(:anonymized_username) {RandomUserName.new(5,10).anonymize(field)}

    it {anonymized_username.should match '^[a-zA-Z0-9]*$'}
  end

end