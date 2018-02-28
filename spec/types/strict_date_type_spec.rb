require 'rails_helper'
RSpec.describe StrictDateType do
  class TestInvalidDate < Date
    def self.new(*)
      super()
    end
  end

  class TestBlankDate < Date
    def blank?
      true
    end
  end

  describe '#cast' do
    subject(:type) { described_class.new(invalid_date_class: TestInvalidDate, blank_date_class: TestBlankDate) }

    it 'casts a valid date hash to a date' do
      expect(type.cast(year: '2010', month: '11', day: '13')).to eql(Date.new(2010, 11, 13))
    end

    it 'casts a valid date hash with zero prefixed months and days to a date' do
      expect(type.cast(year: '2010', month: '09', day: '08')).to eql(Date.new(2010, 9, 8))
    end

    it 'casts a date hash with invalid year to an InvalidDate' do
      expect(type.cast(year: 'invalid', month: '11', day: '13')).to be_a(TestInvalidDate)
    end

    it 'casts a date hash with 2 digit year to an InvalidDate' do
      expect(type.cast(year: '70', month: '11', day: '13')).to be_a(TestInvalidDate)
    end

    it 'casts a date hash with 3 digit year to an InvalidDate' do
      expect(type.cast(year: '170', month: '11', day: '13')).to be_a(TestInvalidDate)
    end

    it 'casts a date hash with invalid month to an InvalidDate' do
      expect(type.cast(year: '2010', month: 'july', day: '13')).to be_a(TestInvalidDate)
    end

    it 'casts a date hash with invalid day to an InvalidDate' do
      expect(type.cast(year: '2010', month: '11', day: 'someday')).to be_a(TestInvalidDate)
    end

    it 'casts a blank hash to nil' do
      expect(type.cast({})).to be_nil
    end

    it 'casts a hash with all blank values to a BlankDate' do
      expect(type.cast(year: '', month: '', day: '')).to be_a(TestBlankDate)
    end

    it 'casts a date if a date is given' do
      expect(type.cast(Date.new(1980, 1, 1))).to eql Date.new(1980, 1, 1)
    end
  end
end
