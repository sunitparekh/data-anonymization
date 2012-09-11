require "spec_helper"

describe DataAnon::Strategy::MongoDB::AnonymizeField do


  it 'should do callback recursive in case of sub document' do
    sub_document = {'key' => 'value'}
    field_strategy = {'key' => FieldStrategy::LoremIpsum.new}
    anonymization_strategy = mock("AnonymizationStrategy")
    anonymization_strategy.should_receive(:anonymize_document).with(sub_document,1,field_strategy).and_return({'key' => "anonymized_value"})
    field = DataAnon::Core::Field.new('sub_document_field', sub_document,1,nil)
    anonymize_field = DataAnon::Strategy::MongoDB::AnonymizeField.new(field, field_strategy,anonymization_strategy)
    anonymized_value = anonymize_field.anonymize
    anonymized_value['key'].should == "anonymized_value"
  end

  it 'should do callback recursive multiple time in case of array of sub document' do
    sub_documents = [{'key' => 'value1'},{'key' => 'value2'}]
    field_strategy = {'key' => FieldStrategy::LoremIpsum.new}
    anonymization_strategy = mock("AnonymizationStrategy")
    anonymization_strategy.should_receive(:anonymize_document).with({'key' => 'value1'},1,field_strategy).and_return({'key' => "anonymized_value1"})
    anonymization_strategy.should_receive(:anonymize_document).with({'key' => 'value2'},1,field_strategy).and_return({'key' => "anonymized_value2"})
    field = DataAnon::Core::Field.new('sub_document_field', sub_documents,1,nil)
    anonymize_field = DataAnon::Strategy::MongoDB::AnonymizeField.new(field, field_strategy,anonymization_strategy)
    anonymized_value = anonymize_field.anonymize
    anonymized_value.length.should == 2
    anonymized_value[0]['key'].should == "anonymized_value1"
    anonymized_value[1]['key'].should == "anonymized_value2"
  end

  it 'should anonymize array field data type' do
    anonymization_strategy = mock("AnonymizationStrategy")
    anonymization_strategy.should_not_receive(:anonymize_document)
    field = DataAnon::Core::Field.new('tags',['tag1','tag2'],1,nil)
    anonymize_field = DataAnon::Strategy::MongoDB::AnonymizeField.new(field,FieldStrategy::SelectFromList.new(['tag4','tag5','tag6','tag7','tag8']),anonymization_strategy)
    anonymized_value = anonymize_field.anonymize
    anonymized_value.length == 2
    ['tag4','tag5','tag6','tag7','tag8'].should include(anonymized_value[0])
    ['tag4','tag5','tag6','tag7','tag8'].should include(anonymized_value[1])
  end

  it 'should anonymize field and return anonymized value using passed strategy' do
    anonymization_strategy = mock("AnonymizationStrategy")
    anonymization_strategy.should_not_receive(:anonymize_document)
    field = DataAnon::Core::Field.new('boolean_field',false,1,nil)
    anonymize_field = DataAnon::Strategy::MongoDB::AnonymizeField.new(field,FieldStrategy::RandomBoolean.new,anonymization_strategy)
    anonymized_value = anonymize_field.anonymize
    [true, false].should include(anonymized_value)
  end


end