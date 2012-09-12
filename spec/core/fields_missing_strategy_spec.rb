require "spec_helper"

describe DataAnon::Core::FieldsMissingStrategy do

  FMS = DataAnon::Core::FieldsMissingStrategy

  it "should be able to add field for new table that doesn't exist" do
    users = FMS.new("users")
    users.missing("confirm_email")
    users.fields_missing_strategy.should == ["confirm_email"]
  end

  it "should be able to take care for same field appearing multiple time" do
    users = FMS.new("users")
    users.missing("confirm_email")
    users.missing("confirm_email")
    users.fields_missing_strategy.should == ["confirm_email"]
  end

  it "should be able to add multiple fields for table" do
    users = FMS.new("users")
    users.missing("confirm_email")
    users.missing("password_reset")
    users.fields_missing_strategy.should == ["confirm_email","password_reset"]
  end
end