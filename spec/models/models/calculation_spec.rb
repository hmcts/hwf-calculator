require 'rails_helper'
RSpec.describe Calculation do
  describe '#initialize' do
    it 'provides default values' do
      subject = described_class.new
      expect(subject).to have_attributes inputs: {},
                                         available_help: :undecided,
                                         fields_required: [],
                                         required_fields_affecting_likelihood: [],
                                         messages: [],
                                         fields: {}
    end
  end

  describe '#inputs' do
    it 'converts the provided value' do
      subject = described_class.new inputs: { marital_status: :value }
      expect(subject.inputs).to eql(marital_status: 'value')
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

  describe '#required_fields_affecting_likelihood' do
    it 'stores a provided value of any type' do
      subject = described_class.new required_fields_affecting_likelihood: [:any]
      expect(subject.required_fields_affecting_likelihood).to eql [:any]
    end
  end

  describe '#fields' do
    it 'stores a provided value of any type' do
      subject = described_class.new fields: { name: :any }
      expect(subject.fields).to eql(name: :any)
    end
  end
end
