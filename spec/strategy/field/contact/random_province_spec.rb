require "spec_helper"

describe DataAnon::Strategy::Field::RandomProvince do

  RandomProvince = DataAnon::Strategy::Field::RandomProvince
  let(:field) { DataAnon::Core::Field.new('province', 'Atlanta', 1, nil) }

  describe 'anonymized province should be different from original province' do
    let(:anonymized_province) { RandomProvince.region_US.anonymize(field) }

    it { anonymized_province.should_not be_nil }
    it { anonymized_province.should_not eq("Atlanta") }
  end
end