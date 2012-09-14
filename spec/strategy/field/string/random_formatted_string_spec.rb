require "spec_helper"

describe FieldStrategy::RandomFormattedString do

  RandomFormattedString = FieldStrategy::RandomFormattedString

  describe 'anonymized credit card number preserving the format' do
    let(:field) {DataAnon::Core::Field.new('credit_card_number',"1111-2222-3333-4444",1,nil)}
    let(:anonymized_value) {RandomFormattedString.new.anonymize(field)}

    it {anonymized_value.should_not equal field.value}
    it { anonymized_value.should match /^\d{4}-\d{4}-\d{4}-\d{4}$/}
  end

  describe 'anonymized email preserving the format' do
    let(:field) {DataAnon::Core::Field.new('email',"parekh1.sunit@gmail.com",1,nil)}
    let(:anonymized_value) {RandomFormattedString.new.anonymize(field)}

    it {anonymized_value.should_not equal field.value}
    it { anonymized_value.should match /^[a-z]{6}\d\.[a-z]{5}@[a-z]{5}\.[a-z]{3}$/}
  end

  describe 'anonymized string preserving the string case & format' do
    let(:field) {DataAnon::Core::Field.new('email',"parekh1.SUNIT@gmail.com",1,nil)}
    let(:anonymized_value) {RandomFormattedString.new.anonymize(field)}

    it {anonymized_value.should_not equal field.value}
    it { anonymized_value.should match /^[a-z]{6}\d\.[A-Z]{5}@[a-z]{5}\.[a-z]{3}$/}
  end

  describe 'anonymized phone# preserving the format' do
    let(:field) {DataAnon::Core::Field.new('home_phone',"(020)3423-8013",1,nil)}
    let(:anonymized_value) {RandomFormattedString.new.anonymize(field)}

    it {anonymized_value.should_not equal field.value}
    it { anonymized_value.should match /^\(\d{3}\)\d{4}-\d{4}$/}
  end

end