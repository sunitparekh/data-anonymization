require "spec_helper"

describe FieldStrategy::RandomFirstName do

  RandomFirstName = FieldStrategy::RandomFirstName
  let(:field) {DataAnon::Core::Field.new('firstname','fakeFirstName',1,nil)}

  describe 'anonymized name must not be the same as provided name' do
    let(:anonymized_value) {RandomFirstName.new().anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

end