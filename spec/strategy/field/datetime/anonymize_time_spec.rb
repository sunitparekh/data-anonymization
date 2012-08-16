require "spec_helper"

describe FieldStrategy::AnonymizeTime do

  AnonymizeTime = FieldStrategy::AnonymizeTime
  let(:field) { DataAnon::Core::Field.new('date', Time.new(2000,1,1,12,12,12), 1, nil) }

  describe 'providing true only for month should randomize only the month field' do

    let(:anonymized_time) { AnonymizeTime.only_month.anonymize(field) }

    it { anonymized_time.should be_kind_of Time}
    it { anonymized_time.year.should be 2000 }
    it { anonymized_time.month.should be_between(1,12)}
    it { anonymized_time.day.should be 1 }
    it { anonymized_time.hour.should be 12}
    it { anonymized_time.min.should be 12}
    it { anonymized_time.sec.should be 12}
  end

  describe 'providing true only for date should randomize only the date field' do

    let(:anonymized_time) { AnonymizeTime.only_day.anonymize(field) }

    it { anonymized_time.year.should be 2000 }
    it { anonymized_time.month.should be 1}
    it { anonymized_time.day.should be_between(1,31) }
    it { anonymized_time.hour.should be 12}
    it { anonymized_time.min.should be 12}
    it { anonymized_time.sec.should be 12}
  end

  describe 'providing true only for hour should randomize only the hour field' do

    let(:anonymized_time) { AnonymizeTime.only_hour.anonymize(field) }

    it { anonymized_time.year.should be 2000 }
    it { anonymized_time.month.should be 1}
    it { anonymized_time.day.should be 1 }
    it { anonymized_time.hour.should be_between(1,24)}
    it { anonymized_time.min.should be 12}
    it { anonymized_time.sec.should be 12}
  end

  describe 'providing true only for minute should randomize only the minute field' do

    let(:anonymized_time) { AnonymizeTime.only_minute.anonymize(field) }

    it { anonymized_time.year.should be 2000 }
    it { anonymized_time.month.should be 1}
    it { anonymized_time.day.should be 1 }
    it { anonymized_time.hour.should be 12}
    it { anonymized_time.min.should be_between(1,60)}
    it { anonymized_time.sec.should be 12}
  end

end