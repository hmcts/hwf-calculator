require 'rails_helper'
RSpec.describe BenefitsReceivedForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :benefits_received' do
      expect(form.type).to be :benefits_received
    end
  end

  describe '#export' do
    it 'exports the benefits' do
      form.benefits_received = ['benefit 1', 'benefit 2']
      expect(form.export).to eql(benefits_received: ['benefit 1', 'benefit 2'])
    end
  end
end
