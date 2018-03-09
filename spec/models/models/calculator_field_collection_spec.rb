require 'rails_helper'
RSpec.describe CalculatorFieldCollection do
  describe '#fields_required' do
    it 'calculates the fields required' do
      subject = described_class.new marital_status: 'sharing_income', fee: 100.0, date_of_birth: 30.years.ago
      expect(subject.fields_required).to eql [:partner_date_of_birth, :disposable_capital, :benefits_received, :number_of_children, :total_income]
    end

    it 'includes any invalidated fields in the correct order for a single status' do
      subject = described_class.new fee: 1000.0, marital_status: 'single', date_of_birth: 60.years.ago, partner_date_of_birth: nil, disposable_capital: 10.0, benefits_received: ['none']
      subject[:marital_status] = 'sharing_income'
      expect(subject.fields_required).to eql [:partner_date_of_birth, :disposable_capital, :benefits_received, :number_of_children, :total_income]
    end

    it 'includes any invalidated fields in the correct order for a sharing_income status' do
      subject = described_class.new fee: 1000.0, marital_status: 'sharing_income', date_of_birth: 60.years.ago, disposable_capital: 10.0, partner_date_of_birth: 60.years.ago, benefits_received: ['none']
      subject[:marital_status] = 'single'
      expect(subject.fields_required).to eql [:disposable_capital, :benefits_received, :number_of_children, :total_income]
    end

    it 'includes partner_date_of_birth if marital status is sharing_income' do
      subject = described_class.new marital_status: 'sharing_income', fee: 100.0, date_of_birth: 30.years.ago
      expect(subject.fields_required).to include :partner_date_of_birth
    end

    it 'does not include partner date_of_birth if marital status is single' do
      subject = described_class.new marital_status: 'single', fee: 100.0, date_of_birth: 30.years.ago
      expect(subject.fields_required).not_to include :partner_date_of_birth
    end
  end

  describe '#[]=' do
    it 're requires disposable capital, benefits received and number of children when marital status is changed from single to sharing_income' do
      subject = described_class.new fee: 1000.0, marital_status: 'single', date_of_birth: 60.years.ago, disposable_capital: 10.0, number_of_children: 2, benefits_received: ['none']
      subject[:marital_status] = 'sharing_income'
      expect(subject.fields_required).to eql [:partner_date_of_birth, :disposable_capital, :benefits_received, :number_of_children, :total_income]
    end
  end
end
