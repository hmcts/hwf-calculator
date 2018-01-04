require 'rails_helper'
RSpec.describe TotalIncomeForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :total_income' do
      expect(form.type).to be :total_income
    end
  end

  describe '#export' do
    it 'exports the total income' do
      form.total_income = '10000'
      expect(form.export).to eql(total_income: 10000.0)
    end
  end
end
