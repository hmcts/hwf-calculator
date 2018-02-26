require 'rails_helper'
RSpec.describe CalculationRepository do
  context 'with simple hash store' do
    subject(:repo) { described_class.new(store: store) }

    let(:store) { {} }

    describe '#find' do
      it 'returns an empty instance of Calculation when store is empty' do
        result = repo.find

        expect(result).to be_a Calculation
      end

      it 'returns a new empty instance if the version saved is an incompatible version' do
        original = Calculation.new(inputs: { marital_status: 'single' }, available_help: :undecided)
        repo.save(original)

        repo2 = described_class.new(store: store, version: described_class.version + 1)
        result = repo2.find

        expect(result.inputs).to have_attributes to_hash: {}
      end
    end

    describe '#save' do
      it 'saves a calculation' do
        original = Calculation.new(inputs: { marital_status: 'single' }, available_help: :undecided)
        repo.save(original)

        fetched = repo.find
        expect(fetched).to have_attributes inputs: having_attributes(to_hash: { marital_status: 'single' }), available_help: :undecided
      end
    end

    describe '#delete_all' do
      it 'resets to a blank calculation' do
        original = Calculation.new(inputs: { marital_status: 'single' }, available_help: :undecided)
        repo.save(original)

        repo.delete_all

        fetched = repo.find
        expect(fetched).to have_attributes inputs: having_attributes(to_hash: {})
      end
    end
  end
end
