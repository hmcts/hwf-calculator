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

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(marital_status: 'sharing_income', some_other_field: 12)
      expect(subject.marital_status).to eql('sharing_income')
    end
  end

  describe 'type' do
    it 'returns :marital_status' do
      expect(described_class.type).to be :marital_status
    end
  end

  describe '#export' do
    it 'exports the marital_status' do
      form_marital_status.marital_status = 'sharing_income'
      expect(form_marital_status.export).to eql(marital_status: 'sharing_income')
    end
  end

  describe 'has_attribute?' do
    it 'returns true for :benefits_received' do
      expect(described_class.has_attribute?(:marital_status)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.has_attribute?(:a_wrong_field)).to be false
    end
  end
end
