require "spec_helper"

describe DataAnon::Strategy::Field::RandomEmail do

  RandomEmail = DataAnon::Strategy::Field::RandomEmail
  let(:field) {DataAnon::Core::Field.new('email','real@email.com',1,nil)}


  describe 'anonymized email must be different from original email' do

    let(:anonymized_value) {RandomEmail.new().anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

  describe 'anonymized email should be a valid email address' do

    let(:anonymized_value) {RandomEmail.new().anonymize(field)}

    it {anonymized_value.should match '^\S+@\S+\.\S+$'}
  end

end