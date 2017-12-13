require 'rails_helper'
RSpec.describe FeeForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :fee' do
      expect(form.type).to be :fee
    end
  end

  describe '#export' do
    it 'exports the fee' do
      form.fee = '10000'
      expect(form.export).to eql(fee: 10000.0)
    end
  end
end
