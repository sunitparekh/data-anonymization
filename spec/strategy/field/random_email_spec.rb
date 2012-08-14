require "spec_helper"

describe FieldStrategy::RandomEmail do

  RandomEmail = FieldStrategy::RandomEmail
  let(:field) {DataAnon::Core::Field.new('email','real@email.com',1,nil)}


  describe 'anonymized email must be different from original email' do

    let(:anonymized_value) {RandomEmail.new.anonymize(field)}

    it {anonymized_value.should_not equal field.value}
    it {anonymized_value.should match '^\S+@\S+\.\S+$'}

  end

end