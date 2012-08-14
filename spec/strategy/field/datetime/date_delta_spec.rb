require "spec_helper"

describe FieldStrategy::DateDelta do

  DateDelta = FieldStrategy::DateDelta
  let(:field) { DataAnon::Core::Field.new('date', Date.new(2011,4,7), 1, nil) }

  describe 'date should not remain the same' do

    let(:anonymized_value) { DateDelta.new().anonymize(field) }
    let(:date_difference) {anonymized_value - field.value}

    it { anonymized_value.should be_kind_of Date}
    it { anonymized_value.should_not == Date.new(2011,4,7) }
    it { date_difference.should be_between(-5.days, 5.days) }
  end

  describe 'date should not change when provided with 0 delta for both date and time' do

    let(:anonymized_date) { DateDelta.new(0).anonymize(field) }

    it {anonymized_date.should == Date.new(2011,4,7) }

  end

  describe 'date should be anonymized within provided delta' do

    let(:anonymized_value) { DateDelta.new(5).anonymize(field) }
    let(:date_difference) {anonymized_value - field.value}

    it { date_difference.should be_between(-5.days, 5.days) }

  end


end