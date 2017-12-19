require 'rails_helper'
RSpec.describe DisposableCapitalForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :disposable_capital' do
      expect(form.type).to be :disposable_capital
    end
  end

  describe '#export' do
    it 'exports the fee' do
      form.disposable_capital = '10000'
      expect(form.export).to eql(disposable_capital: 10000.0)
    end
  end
end
