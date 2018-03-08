require 'rails_helper'
RSpec.describe Calculation do
  describe '#initialize' do
    it 'provides default values' do
      subject = described_class.new
      expect(subject).to have_attributes inputs: instance_of(CalculatorFieldCollection),
                                         available_help: :undecided,
                                         messages: [],
                                         remission: 0.0,
                                         final_decision_by: :none
    end
  end

  describe '#inputs' do
    it 'stores the provided values as a field collection' do
      subject = described_class.new inputs: { marital_status: 'value' }
      expect(subject.inputs).to be_a(CalculatorFieldCollection).and(have_attributes(to_hash: { marital_status: 'value' }))
    end
  end

  describe '#merge_inputs' do
    it 'merges the new values on top of the old' do
      subject = described_class.new inputs: { marital_status: 'single' }
      subject.merge_inputs marital_status: 'sharing_income'
      expect(subject.inputs[:marital_status]).to eql('sharing_income')
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

  describe '#reset_messages' do
    it 'clears out any old messages' do
      subject = described_class.new messages: [:any]
      subject.reset_messages
      expect(subject.messages).to be_empty
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

  describe '#freeze' do
    it 'freezes the messages array' do
      subject = described_class.new messages: [:any]
      subject.freeze

      expect(subject.messages).to be_frozen
    end
  end

  describe '#freeze_if_frozen' do
    it 'freezes the object if the frozen attribute is true' do
      subject = described_class.new
      subject.frozen = true
      subject.freeze_if_frozen

      expect(subject).to be_frozen
    end

    it 'does not freezes the object if the frozen attribute is not true' do
      subject = described_class.new
      subject.frozen = false
      subject.freeze_if_frozen

      expect(subject).not_to be_frozen
    end
  end
end
