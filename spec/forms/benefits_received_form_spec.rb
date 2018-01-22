require 'rails_helper'
RSpec.describe BenefitsReceivedForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    describe '#benefits_received' do
      it 'is invalid if nil' do
        form.benefits_received = nil
        expect(form.valid?).to be false
      end

      it 'is invalid if empty array' do
        form.benefits_received = []
        expect(form.valid?).to be false
      end

      it 'contains the correct error if empty array' do
        form.benefits_received = []
        form.valid?
        expect(form.errors.added?(:benefits_received, :blank)).to be true
      end

      it 'is invalid if a string' do
        form.benefits_received = 'wrong'
        expect(form.valid?).to be false
      end

      it 'is invalid if "none" is present along with "dont_know"' do
        form.benefits_received = ['none', 'dont_know']
        expect(form.valid?).to be false
      end

      it 'is invalid if "none" is present along with any benefit' do
        form.benefits_received = ['none', 'jobseekers_allowance']
        expect(form.valid?).to be false
      end

      it 'is invalid if an unknown benefit is provided' do
        form.benefits_received = ['this_is_not_a_benefit']
        expect(form.valid?).to be false
      end

      it 'is invalid if "dont_know" is present along with any benefit' do
        form.benefits_received = ['dont_know', 'jobseekers_allowance']
        expect(form.valid?).to be false
      end

      it 'is valid if a single valid benefit is present' do
        form.benefits_received = ['jobseekers_allowance']
        expect(form.valid?).to be true
      end

      it 'is valid if 2 valid benefits are present' do
        form.benefits_received = ['jobseekers_allowance', 'income_support']
        expect(form.valid?).to be true
      end

      it 'contains no errors after validation when 2 valid benefits are present' do
        form.benefits_received = ['jobseekers_allowance', 'income_support']
        form.valid?
        expect(form.errors.include?(:benefits_received)).to be false
      end
    end
  end

  describe 'type' do
    it 'returns :benefits_received' do
      expect(described_class.type).to be :benefits_received
    end
  end

  describe '#export' do
    it 'exports the benefits' do
      form.benefits_received = ['benefit 1', 'benefit 2']
      expect(form.export).to eql(benefits_received: ['benefit 1', 'benefit 2'])
    end
  end

  describe '#benefits_received=' do
    it 'filters blanks' do
      form.benefits_received = ['', 'benefit 1']
      expect(form.benefits_received).to eql ['benefit 1']
    end
  end

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(benefits_received: ['benefit 1'], some_other_field: 12)
      expect(subject.benefits_received).to eql(['benefit 1'])
    end
  end

  describe 'attribute?' do
    it 'returns true for :benefits_received' do
      expect(described_class.attribute?(:benefits_received)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.attribute?(:a_wrong_field)).to be false
    end
  end
end
