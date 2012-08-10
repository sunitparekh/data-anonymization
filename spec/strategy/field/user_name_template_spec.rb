require "spec_helper"

describe DataAnon::Strategy::Field::UserNameTemplate do

  UserNameTemplate = DataAnon::Strategy::Field::UserNameTemplate
  let(:field) { DataAnon::Core::Field.new('username', 'Chuck Norris', 100, nil) }

  describe 'should return same string value as StringTemplate' do
    let(:anonymized_username) { UserNameTemplate.new('Rajnikanth #{row_number}').anonymize(field) }
    it { anonymized_username.should == 'Rajnikanth 100' }
  end

end