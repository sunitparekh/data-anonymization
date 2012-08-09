require "spec_helper"

describe DataAnon::Strategy::Field::RandomFirstName do

  RandomFirstName = DataAnon::Strategy::Field::RandomFirstName
  let(:field) {DataAnon::Core::Field.new('firstname','fakeFirstName',1,nil)}

  describe 'anonymized name must not be the same as provided name' do
    let(:anonymized_value) {RandomFirstName.new().anonymize(field.value)}

    it {anonymized_value.should_not equal field.value}
  end

end