require "spec_helper"

describe FieldStrategy::DefaultAnon do

  DefaultAnon = FieldStrategy::DefaultAnon

  describe 'anonymized boolean true value' do
    let(:field) {DataAnon::Core::Field.new('boolean_field',true,1,nil)}
    let(:anonymized_value) {DefaultAnon.new.anonymize(field)}

    it { [TrueClass,FalseClass].should include(anonymized_value.class)  }
  end

  describe 'anonymized boolean false value' do
    let(:field) {DataAnon::Core::Field.new('boolean_field',false,1,nil)}
    let(:anonymized_value) {DefaultAnon.new.anonymize(field)}

    it { [TrueClass,FalseClass].should include(anonymized_value.class)  }
  end

  describe 'anonymized float value' do
    let(:field) {DataAnon::Core::Field.new('float_field',2.0,1,nil)}
    let(:anonymized_value) {DefaultAnon.new.anonymize(field)}

    it { anonymized_value.should be_kind_of Float  }
  end

  describe 'anonymized int value' do
    let(:field) {DataAnon::Core::Field.new('int_field',2,1,nil)}
    let(:anonymized_value) {DefaultAnon.new.anonymize(field)}

    it { anonymized_value.should be_kind_of Fixnum  }
  end

  describe 'anonymized bignum value' do
    let(:field) {DataAnon::Core::Field.new('int_field',2348723489723847382947,1,nil)}
    let(:anonymized_value) {DefaultAnon.new.anonymize(field)}

    it { anonymized_value.should be_kind_of Bignum  }
  end

  describe 'anonymized string value' do
    let(:field) {DataAnon::Core::Field.new('string_field','String',1,nil)}
    let(:anonymized_value) {DefaultAnon.new.anonymize(field)}

    it { anonymized_value.should be_kind_of String  }
  end

end