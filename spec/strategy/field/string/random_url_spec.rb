require "spec_helper"

describe FieldStrategy::RandomUrl do

  RandomUrl = FieldStrategy::RandomUrl

  describe 'anonymized url must not be the same as original url' do
    let(:field) {DataAnon::Core::Field.new('string_field','http://fakeurl.com',1,nil)}
    let(:anonymized_url) {RandomUrl.new.anonymize(field)}

    it {anonymized_url.should_not equal field.value}
    it {anonymized_url.should match /https?:\/\/[\S]+/}
  end

end