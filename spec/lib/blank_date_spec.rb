require 'rails_helper'
RSpec.describe BlankDate do
  subject(:blank_date) { described_class.new }

  describe '#blank?' do
    it 'returns true' do
      expect(blank_date.blank?).to be true
    end
  end

  describe '#day' do
    it 'returns nil' do
      expect(blank_date.day).to be nil
    end
  end

  describe '#month' do
    it 'returns nil' do
      expect(blank_date.month).to be nil
    end
  end

  describe '#year' do
    it 'returns nil' do
      expect(blank_date.year).to be nil
    end
  end

  describe 'is_a?' do
    it 'must be a date' do
      expect(blank_date.is_a?(Date)).to be true
    end
  end
end
