require 'rails_helper'
RSpec.describe Field, type: :model do
  subject(:field) { described_class.new('key', 'value') }

  describe '#initialize' do
    it 'takes 2 parameters' do
      expect(field).to be_a(described_class)
    end
  end

  describe '#value' do
    it 'returns the value provided' do
      expect(field.value).to eql 'value'
    end
  end

  describe '#invalidate' do
    it 'marks the field as invalidated' do
      field.invalidate
      expect(field.invalidated).to be true
    end
  end

  describe '#invalidate' do
    it 'marks the field as invalidated' do
      field.invalidate
      field.confirm
      expect(field.invalidated).to be false
    end
  end
end
