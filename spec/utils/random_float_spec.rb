require "spec_helper"

describe "Number Utils" do

  describe 'should return same length value using default text' do

    let(:random_float) { DataAnon::Utils::RandomFloat.generate(5,10) }

    it { random_float.should be_between(5,10) }
    it { random_float.should be_a_kind_of Float }
  end
end