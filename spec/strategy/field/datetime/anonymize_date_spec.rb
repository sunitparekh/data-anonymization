require "spec_helper"

describe FieldStrategy::AnonymizeDate do

  AnonymizeDate = FieldStrategy::AnonymizeDate
  let(:field) { DataAnon::Core::Field.new('date', Date.new(2011,7,5), 1, nil) }

  describe 'providing true only for month should randomize only the month field' do

    let(:anonymized_time) { AnonymizeDate.only_month.anonymize(field) }

    it { anonymized_time.should be_kind_of Date}
    it { anonymized_time.year.should be 2011 }
    it { anonymized_time.month.should be_between(1,12)}
    it { anonymized_time.day.should be 5 }
  end

  describe 'providing true only for date should randomize only the date field' do

    let(:anonymized_time) { AnonymizeDate.only_day.anonymize(field) }

    it { anonymized_time.year.should be 2011 }
    it { anonymized_time.month.should be 7}
    it { anonymized_time.day.should be_between(1,31) }
  end

end