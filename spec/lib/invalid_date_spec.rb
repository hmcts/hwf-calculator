require 'rails_helper'
require 'invalid_date'
RSpec.describe InvalidDate do
  subject(:invalid_date) { described_class.new('invalid year', 'invalid month', 'invalid day') }

  describe '#blank?' do
    it 'returns false' do
      expect(invalid_date.blank?).to be false
    end
  end

  describe '#valid?' do
    it 'returns false' do
      expect(invalid_date.valid?).to be false
    end
  end

  describe '#day' do
    it 'returns what was passed in' do
      expect(invalid_date.day).to eql 'invalid day'
    end
  end

  describe '#month' do
    it 'returns what was passed in' do
      expect(invalid_date.month).to eql 'invalid month'
    end
  end

  describe '#year' do
    it 'returns what was passed in' do
      expect(invalid_date.year).to eql 'invalid year'
    end
  end

  describe 'is_a?' do
    it 'must be a date' do
      expect(invalid_date.is_a?(Date)).to be true
    end
  end
end
