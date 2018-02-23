require 'rails_helper'
RSpec.describe Calculation do
  describe '#initialize' do
    it 'provides default values' do
      subject = described_class.new
      expect(subject).to have_attributes inputs: {},
                                         available_help: :undecided,
                                         fields_required: [],
                                         messages: [],
                                         fields: {},
                                         remission: 0.0,
                                         final_decision_by: :none
    end
  end

  describe '#inputs' do
    it 'stores the provided values as they are' do
      subject = described_class.new inputs: { marital_status: 'value' }
      expect(subject.inputs).to eql(marital_status: 'value')
    end
  end

  describe '#merge_inputs' do
    it 'merges the new values on top of the old' do
      subject = described_class.new inputs: { marital_status: 'single' }
      subject.merge_inputs marital_status: 'sharing_income'
      expect(subject.inputs).to eql(marital_status: 'sharing_income')
    end
  end

  describe '#available_help' do
    it 'stores a provided value of any type' do
      subject = described_class.new available_help: :full
      expect(subject.available_help).to be :full
    end
  end

  describe '#remission' do
    it 'stores a provided float' do
      subject = described_class.new remission: 0.0
      expect(subject.remission).to be 0.0
    end
  end

  describe '#messages' do
    it 'stores a provided value of any type' do
      subject = described_class.new messages: [:any]
      expect(subject.messages).to eql [:any]
    end
  end

  describe '#fields_required' do
    it 'stores a provided value of any type' do
      subject = described_class.new fields_required: [:any]
      expect(subject.fields_required).to eql [:any]
    end
  end

  describe '#fields' do
    it 'stores a provided value of any type' do
      subject = described_class.new fields: { name: :any }
      expect(subject.fields).to eql(name: :any)
    end
  end

  describe '#final_decision_by' do
    it 'stores a provided value of any type' do
      subject = described_class.new final_decision_by: 'none'
      expect(subject.final_decision_by).to eql('none')
    end
  end

  describe '#final_decision_made?' do
    it 'returns true if the final decision is not none' do
      subject = described_class.new final_decision_by: :anythingelse
      expect(subject.final_decision_made?).to be true
    end

    it 'returns false if the final decision is none' do
      subject = described_class.new final_decision_by: :none
      expect(subject.final_decision_made?).to be false
    end

  end
end
