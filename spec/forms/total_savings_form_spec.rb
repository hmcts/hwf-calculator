require 'rails_helper'
RSpec.describe TotalSavingsForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :total_savings' do
      expect(form.type).to be :total_savings
    end
  end

  describe '#export' do
    it 'exports the fee' do
      form.total_savings = '10000'
      expect(form.export).to eql(total_savings: 10000.0)
    end
  end
end
