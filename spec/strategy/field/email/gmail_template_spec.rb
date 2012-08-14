require "spec_helper"

describe FieldStrategy::GmailTemplate do

  GmailTemplate = FieldStrategy::GmailTemplate
  let(:field) { DataAnon::Core::Field.new('email', 'user@company.com', 456, nil) }

  describe 'generated email using default username' do
    let(:anonymized_email) { GmailTemplate.new.anonymize(field) }
    it { anonymized_email.should eq('someusername+456@gmail.com') }
  end

  describe 'generated email using given username' do
    let(:anonymized_email) { GmailTemplate.new("fake").anonymize(field) }
    it { anonymized_email.should eq('fake+456@gmail.com') }
  end
end