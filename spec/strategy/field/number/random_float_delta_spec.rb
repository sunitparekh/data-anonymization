require "spec_helper"

describe FieldStrategy::RandomFloatDelta do

  RandomFloatDelta = FieldStrategy::RandomFloatDelta
  let(:field) {DataAnon::Core::Field.new('float_field',5.5,1,nil)}

  describe 'anonymized float should not be the same as original value' do
    let(:anonymized_value) {RandomFloatDelta.new(5).anonymize(field)}

    it {anonymized_value.should_not equal field.value}
  end

  describe 'anonymized value returned should be a float' do
    let(:anonymized_value) {RandomFloatDelta.new(5).anonymize(field)}

    it { anonymized_value.should be_kind_of Float }
  end
end