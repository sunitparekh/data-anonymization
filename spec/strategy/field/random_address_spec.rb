require "spec_helper"

describe DataAnon::Strategy::Field::RandomAddress do

  RandomAddress = DataAnon::Strategy::Field::RandomAddress
  let(:field) {DataAnon::Core::Field.new('address','1 Infinite Loop',1,nil)}

  describe 'anonymized address should be different from original address' do
    let(:anonymized_address) {RandomAddress.new.anonymize(field)}
    it {anonymized_address.should_not eq("1 Infinite Loop")}
  end
end