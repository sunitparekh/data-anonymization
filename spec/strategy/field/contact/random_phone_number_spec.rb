require "spec_helper"

describe FieldStrategy::RandomPhoneNumber do

  RandomPhoneNumber = FieldStrategy::RandomPhoneNumber
  let(:field) { DataAnon::Core::Field.new('phone_number', "+0 (123) 456-7890", 1, nil) }

  describe 'anonymized phone number preserving the format' do
    let(:anonymized_number) { RandomPhoneNumber.new().anonymize(field) }

    it { anonymized_number.should_not equal field.value }
    it { anonymized_number.should match /\+\d\ \(\d{3}\)\ \d{3}-\d{4}$/ }
  end


end