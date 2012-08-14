require "spec_helper"

describe FieldStrategy::RandomFloatDelta do

  RandomFloatDelta = FieldStrategy::RandomFloatDelta
  let(:field) {DataAnon::Core::Field.new('float_field',5.5,1,nil)}

  describe 'anonymized float should not be the same as original value' do
    let(:anonymized_float) {RandomFloatDelta.new(5).anonymize(field)}

    it {anonymized_float.should_not equal field.value}
  end

  describe 'anonymized value returned should be a float' do
    let(:anonymized_float) {RandomFloatDelta.new(5).anonymize(field)}

    it { is_float = anonymized_float.is_a? Float
         is_float.should be true
    }
  end
end