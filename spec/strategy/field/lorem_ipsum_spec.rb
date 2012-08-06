require "spec_helper"

describe DataAnon::Strategy::Field::LoremIpsum do

  LoremIpsum = DataAnon::Strategy::Field::LoremIpsum
  let(:field) { DataAnon::Core::Field.new('state', 'New Delhi', 1, nil) }

  describe 'should return same length value using default text' do

    let(:anonymized_value) { LoremIpsum.new.anonymize(field) }

    it { anonymized_value.length.should_not be('New Delhi') }
    it { anonymized_value.length.should == 'New Delhi'.length }

  end

  describe 'should return same length value using set text' do

    let(:anonymized_value) { LoremIpsum.new("Sunit Parekh").anonymize(field) }

    it { anonymized_value.length.should_not be('New Delhi') }
    it { anonymized_value.should == 'Sunit Par' }

  end


end