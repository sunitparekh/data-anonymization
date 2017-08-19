require 'spec_helper'

describe FieldStrategy::RandomBoolean do

  RandomBoolean = FieldStrategy::RandomBoolean
  let(:field) {DataAnon::Core::Field.new('boolean_field',true,1,nil)}

  describe 'anonymized value should be a boolean' do
    let(:anonymized_boolean) {RandomBoolean.new.anonymize(field)}

    it {
      is_boolean = anonymized_boolean.is_a?(TrueClass) || anonymized_boolean.is_a?(FalseClass)
      is_boolean.should be true
    }
  end
end