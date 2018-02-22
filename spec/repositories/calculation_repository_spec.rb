require 'rails_helper'
RSpec.describe CalculationRepository do
  context 'with simple hash store' do
    let(:store) { {} }
    subject(:repo) { described_class.new(store: store) }

    context '#find' do
      it 'returns an empty instance of Calculation when store is empty' do
        result = subject.find

        expect(result).to be_a Calculation
      end

    end

    context '#save' do
      it 'saves a calculation' do
        original = Calculation.new(inputs: {marital_status: 'single'}, available_help: :undecided)
        subject.save(original)

        fetched = subject.find
        expect(fetched).to have_attributes inputs: {marital_status: 'single'}, available_help: :undecided
      end
    end

    context '#delete_all' do
      it 'resets to a blank calculation' do
        original = Calculation.new(inputs: {marital_status: 'single'}, available_help: :undecided)
        subject.save(original)

        subject.delete_all

        fetched = subject.find
        expect(fetched).to have_attributes inputs: {}
      end
    end
  end
end
