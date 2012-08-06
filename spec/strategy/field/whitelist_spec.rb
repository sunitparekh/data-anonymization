require "spec_helper"

describe DataAnon::Strategy::Field::Whitelist do

  Whitelist = DataAnon::Strategy::Field::Whitelist

  describe 'should return same string value as whitelist' do
    let(:field) { DataAnon::Core::Field.new('state', 'New Delhi', 1, nil) }
    let(:anonymized_value) { Whitelist.new.anonymize(field) }
    it { anonymized_value.should == 'New Delhi' }
  end

  describe 'should return same date value as whitelist' do
    let(:dob) { Time.now }
    let(:field) { DataAnon::Core::Field.new('DateOfBirth', dob, 1, nil) }
    let(:anonymized_value) { Whitelist.new.anonymize(field) }
    it { anonymized_value.should == dob }
  end


end