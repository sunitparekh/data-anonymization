require "spec_helper"

describe "Investigation & Debugging Tests" do

  it "test for investigating and debugging" do
    Invoice = Utils::SourceTable.create :invoice
    #pry.binding
  end
end