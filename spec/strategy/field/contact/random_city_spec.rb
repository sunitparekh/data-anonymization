require "spec_helper"

describe DataAnon::Strategy::Field::RandomCity do

  RandomCity = DataAnon::Strategy::Field::RandomCity
  let(:field) { DataAnon::Core::Field.new('city', 'Atlanta', 1, nil) }

  describe 'anonymized city should be different from original city' do
    let(:anonymized_city) { RandomCity.region_US.anonymize(field) }

    it { anonymized_city.should_not be_nil }
    it { anonymized_city.should_not eq("Atlanta") }
  end
end