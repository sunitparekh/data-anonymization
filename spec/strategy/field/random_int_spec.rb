require "spec_helper"

describe FieldStrategy::RandomInt do

  RandomInt = FieldStrategy::RandomInt
  let(:field) { DataAnon::Core::Field.new('age', 25, 1, nil) }

  describe 'verify age range between 18 and 70' do

    let(:anonymized_int) { RandomInt.new(18, 70).anonymize(field) }

    it { anonymized_int.should >= 18 }
    it { anonymized_int.should <= 70 }

  end

  describe 'default range between 0 and 100' do

    let(:anonymized_int) { RandomInt.new.anonymize(field) }

    it { anonymized_int.should >= 0 }
    it { anonymized_int.should <= 100 }

  end



end