require "spec_helper"
require 'bigdecimal'

describe FieldStrategy::RandomBigDecimalDelta do

  RandomBigDecimalDelta = FieldStrategy::RandomBigDecimalDelta
  let(:field) {DataAnon::Core::Field.new('decimal_field',BigDecimal("53422342378687687342893.23324"),1,nil)}

  describe 'anonymized big decimal should not be the same as original value' do
    let(:anonymized_value) {RandomBigDecimalDelta.new.anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

  describe 'anonymized value returned should be big decimal' do
    let(:anonymized_value) {RandomBigDecimalDelta.new.anonymize(field)}

    it { anonymized_value.should be_kind_of BigDecimal }
  end
end