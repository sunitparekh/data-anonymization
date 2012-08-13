require "spec_helper"

describe DataAnon::Strategy::Field::GmailTemplate do

  GmailTemplate = DataAnon::Strategy::Field::GmailTemplate
  let(:field) {DataAnon::Core::Field.new('email','user@company.com',456,nil)}

  describe 'generated email must be compliant with the provided template' do

    let(:anonymized_email) {GmailTemplate.new().anonymize(field)}

    it {anonymized_email.should eq('fake+456@gmail.com')}
  end
end