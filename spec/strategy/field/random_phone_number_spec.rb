require "spec_helper"

describe DataAnon::Strategy::Field::RandomPhoneNumber do

  RandomPhoneNumber = DataAnon::Strategy::Field::RandomPhoneNumber
  let(:field) {DataAnon::Core::Field.new('phone_number',"+0 (123) 456-7890",1,nil)}

  describe 'anonymized phone number should not be the same as original phone number' do
    let(:anonymized_number) {RandomPhoneNumber.new().anonymize(field)}

    it {
      puts anonymized_number
      puts field.value
      anonymized_number.should_not equal field.value}
  end

  describe 'anonymized phone number should be the same formatting as original phone number' do

    it {
      anonymized_number = RandomPhoneNumber.new().anonymize(field)
      original_number = field.value
      counter = 0
      @number_similarity = true
      anonymized_number.each_char do |char|
        original_number_char = original_number[counter]
        if /\d/.match(original_number_char).nil?
          if !char.eql? original_number_char
            @number_similarity = false
            break
          end
        end

      @number_similarity.should be true
      end
    }
  end

end