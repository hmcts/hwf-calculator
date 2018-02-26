require 'rails_helper'
RSpec.describe FieldCollection, type: :model do
  let(:field_values) do
    {
      marital_status: 'single',
      total_income: 1020.0
    }
  end

  describe '#initialize' do
    subject(:collection) { described_class.new(field_values) }
    it 'accepts a hash as initial field values' do
      expect(collection[:marital_status]).to be_present
    end
  end

  describe '#[]' do
    subject(:collection) { described_class.new(field_values) }
    it 'provides access to the underlying value' do
      expect(collection[:total_income]).to eql 1020.0
    end
  end

  describe '#[]=' do
    subject(:collection) { described_class.new(field_values) }
    it 'overwrites existing values' do
      collection[:total_income] = 2020.0
      expect(collection[:total_income]).to eql 2020.0
    end

    it 'adds new values' do
      collection[:fee] = 2020.0
      expect(collection[:fee]).to eql 2020.0
    end

    it 'returns the value provided' do
      expect(collection[:fee] = 2020.0).to eql 2020.0
    end

  end

  describe 'merge!' do
    subject(:collection) { described_class.new(field_values) }
    it 'overwrites existing values' do
      collection.merge!(total_income: 2020.0)
      expect(collection[:total_income]).to eql 2020.0
    end

    it 'adds new values' do
      collection.merge!(fee: 2020.0)
      expect(collection[:fee]).to eql 2020.0
    end

    it 'returns the instance' do
      expect(collection.merge!(fee: 2020.0)).to have_attributes(to_hash: field_values.merge(fee: 2020.0))
    end
  end

  describe 'key?' do
    subject(:collection) { described_class.new(field_values) }
    it 'is true for key marital_status' do
      expect(collection.key?(:marital_status)).to be true
    end

    it 'is false for unknown key' do
      expect(collection.key?(:unknown)).to be false
    end
  end

  describe '#keys' do
    subject(:collection) { described_class.new(field_values) }
    it 'returns the keys from the underlying storage' do
      expect(collection.keys).to eql field_values.keys
    end
  end

  describe '#empty?' do
    it 'returns false with values present' do
      collection = described_class.new(field_values)
      expect(collection.empty?).to be false
    end

    it 'returns true to start with' do
      collection = described_class.new
      expect(collection.empty?).to be true
    end
  end

  describe '#to_hash' do
    subject(:collection) { described_class.new(field_values) }
    it 'provides a hash which equals the field values' do
      expect(collection.to_hash).to eql(field_values)
    end

    it 'provides a hash which is NOT the original' do
      expect(collection.to_hash).not_to be field_values
    end
  end
end