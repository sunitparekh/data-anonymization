require "spec_helper"

describe FieldStrategy::RandomIntegerDelta do

  RandomIntegerDelta = FieldStrategy::RandomIntegerDelta
  let(:field) {DataAnon::Core::Field.new('integer_field',100,1,nil)}

  describe "anonymized value returned should be an integer" do
    let(:anonymized_integer) {RandomIntegerDelta.new(10).anonymize(field)}

    it { is_integer = anonymized_integer.is_a? Integer
         is_integer.should be true
    }

  end

  describe "anonymized integer should be within delta from original integer" do
    let(:anonymized_integer) {RandomIntegerDelta.new(10).anonymize(field)}

    it{anonymized_integer.should be_between(90,110)}
  end

end