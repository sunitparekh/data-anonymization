require "spec_helper"

describe FieldStrategy::RandomUserName do

  RandomUserName = FieldStrategy::RandomUserName
  let(:field) {DataAnon::Core::Field.new('username','fakeUserName',1,nil)}

  describe 'anonymized user name should not be the same as original user name' do
    let(:anonymized_username) {RandomUserName.new.anonymize(field)}

    it {anonymized_username.should_not equal field.value}
    it {anonymized_username.length.should be_between(5,10)}
    it {anonymized_username.should match '^[a-zA-Z0-9]*$'}

  end

  describe 'different length for username' do
    let(:anonymized_username) {RandomUserName.new(15,20).anonymize(field)}

    it {anonymized_username.length.should be_between(15,20)}
  end

end