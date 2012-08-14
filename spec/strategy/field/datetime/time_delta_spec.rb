require "spec_helper"

describe FieldStrategy::TimeDelta do

  TimeDelta = FieldStrategy::TimeDelta
  let(:field) { DataAnon::Core::Field.new('date', Time.new(2012,10,10,13,20,10), 1, nil) }

  describe 'time should not remain the same' do

    let(:anonymized_value) { TimeDelta.new().anonymize(field) }
    let(:date_difference) {anonymized_value.to_i - field.value.to_i}

    it { anonymized_value.should be_kind_of Time}
    it {date_difference.should_not be 0 }
  end

  describe 'time should not change when provided with 0 delta for both date and time' do

    let(:anonymized_value) { TimeDelta.new(0,0).anonymize(field) }
    let(:date_difference) {anonymized_value.to_i - field.value.to_i}

    it {date_difference.should be 0 }

  end

  describe 'date should be anonymized within provided delta' do

    let(:anonymized_value) { TimeDelta.new(5,0).anonymize(field) }
    let(:date_difference) {anonymized_value.to_i - field.value.to_i}

    it { date_difference.should be_between(-5.days, 5.days) }

  end

  describe 'time should be anonymized within provided delta' do

    let(:anonymized_value) { TimeDelta.new(0,10).anonymize(field) }
    let(:date_difference) {anonymized_value.to_i - field.value.to_i}

    it { date_difference.should be_between(-10.minutes, 10.minutes)}
  end


end