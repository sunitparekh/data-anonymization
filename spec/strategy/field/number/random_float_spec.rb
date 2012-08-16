require "spec_helper"

describe FieldStrategy::RandomFloat do

  RandomFloat = FieldStrategy::RandomFloat
  let(:field) { DataAnon::Core::Field.new('points', 2.5, 1, nil) }

  describe 'verify age range between 18 and 70' do

    let(:anonymized_int) { RandomFloat.new(2.0, 8.0).anonymize(field) }

    it { anonymized_int.should >= 2.0 }
    it { anonymized_int.should <= 8.0 }

  end

  describe 'default range between 0 and 100' do

    let(:anonymized_int) { RandomFloat.new.anonymize(field) }

    it { anonymized_int.should >= 0.0 }
    it { anonymized_int.should <= 100.0 }

  end



end