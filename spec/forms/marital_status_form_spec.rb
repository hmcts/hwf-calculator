require 'rails_helper'
RSpec.describe MaritalStatusForm, type: :model do
  subject(:form_marital_status) { described_class.new }

  describe 'validations' do
    describe 'marital_status' do
      context 'when sharing_income' do
        before { form_marital_status.marital_status = 'sharing_income' }

        it { expect(form_marital_status.valid?).to be true }
      end

      context 'when single' do
        before { form_marital_status.marital_status = 'single' }

        it { expect(form_marital_status.valid?).to be true }
      end

      context 'when not a string value' do
        before { form_marital_status.marital_status = false }

        it { expect(form_marital_status.valid?).to be false }
      end
    end
  end

  describe 'type' do
    it 'returns :marital_status' do
      expect(form_marital_status.type).to be :marital_status
    end
  end

  describe '#export' do
    it 'exports the marital_status' do
      form_marital_status.marital_status = 'sharing_income'
      expect(form_marital_status.export).to eql(marital_status: 'sharing_income')
    end
  end
end
