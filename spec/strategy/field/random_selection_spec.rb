require "spec_helper"

describe DataAnon::Strategy::Field::RandomSelection do

  RandomSelection = DataAnon::Strategy::Field::RandomSelection
  let(:field) { DataAnon::Core::Field.new('state', 'New Delhi', 1, nil) }

  describe 'select one of the value from predefined list' do

    let(:states) { ['Maharashtra','Gujrat','Karnataka'] }
    let(:anonymized_value) { RandomSelection.new(states).anonymize(field) }

    it { states.should include(anonymized_value) }

  end


end