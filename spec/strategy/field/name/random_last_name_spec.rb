require "spec_helper"

describe FieldStrategy::RandomLastName do

  RandomLastName = FieldStrategy::RandomLastName
  let(:field) {DataAnon::Core::Field.new('lastname','fakeLastName',1,nil)}

  describe 'anonymized name must not be the same as provided name' do
    let(:anonymized_value) {RandomLastName.new().anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

end