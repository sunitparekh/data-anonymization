require "spec_helper"

describe FieldStrategy::RandomUrl do

  RandomUrl = FieldStrategy::RandomUrl

  describe 'anonymized url must not be the same as original url' do
    let(:url) { 'http://example.org' }

    let(:field) {DataAnon::Core::Field.new('string_field',url,1,nil)}
    let(:anonymized_url) {RandomUrl.new.anonymize(field)}

    it {anonymized_url.should_not equal field.value}
    it {anonymized_url.should match /http:\/\/[\S]+/}

    context 'with https url' do
      let(:url) { 'https://example.org' }

      it {anonymized_url.should_not equal field.value}
      it {anonymized_url.should match /https:\/\/[\S]+/}
    end
  end
end
