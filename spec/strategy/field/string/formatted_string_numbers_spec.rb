require "spec_helper"

describe FieldStrategy::FormattedStringNumber do

  FormattedStringNumber = FieldStrategy::FormattedStringNumber
  let(:field) {DataAnon::Core::Field.new('credit_card_number',"1111-2222-3333-4444",1,nil)}

  describe 'anonymized credit card number preserving the format' do
    let(:anonymized_number) {FormattedStringNumber.new.anonymize(field)}

    it {anonymized_number.should_not equal field.value}
    it { anonymized_number.should match /^\d{4}-\d{4}-\d{4}-\d{4}$/}
  end

end