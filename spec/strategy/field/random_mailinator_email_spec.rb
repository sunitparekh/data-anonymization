require "spec_helper"

describe DataAnon::Strategy::Field::RandomMailinatorEmail do

  RandomMailinatorEmail = DataAnon::Strategy::Field::RandomMailinatorEmail
  let(:field) {DataAnon::Core::Field.new('email','user@company.com',1,nil)}

  describe 'anonymized email should not be the same as original email' do

    let(:anonymized_email) {RandomMailinatorEmail.new().anonymize(field)}

    it {anonymized_email.should_not equal field.value}
  end

  describe 'anonymized email should be a mailinator email address' do

    let(:anonymized_email) {RandomMailinatorEmail.new().anonymize(field)}

    it {anonymized_email.should match '^\S+@\mailinator\.com$'}
  end
end