require "spec_helper"

describe DataAnon::Strategy::Field::AnonymizeTime do

  AnonymizeTime = DataAnon::Strategy::Field::AnonymizeTime
  let(:field) { DataAnon::Core::Field.new('date', Time.new(2000,1,1,12,12,12), 1, nil) }

  describe 'providing true only for month should randomize only the month field' do

    let(:anonymized_time) { AnonymizeTime.new(true,false,false,false,false).anonymize(field) }

    it {
      anonymized_time.year.should be 2000
      anonymized_time.day.should be 1
      anonymized_time.hour.should be 12
      anonymized_time.min.should be 12
      anonymized_time.sec.should be 12

      anonymized_time.month.should be_between(1,12)
    }
  end

end