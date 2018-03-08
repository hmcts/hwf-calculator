require 'rails_helper'
require 'zlib'
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

      it 'returns a new empty instance if the Psych call raises an exception' do
        # Arrange - Store a value and modify it as we have access to the store
        original = Calculation.new(inputs: { marital_status: 'single' }, available_help: :undecided)
        repo.save(original)
        data = store.values.last
        original_yaml = Zlib::Inflate.inflate(YAML.safe_load(data))
        original_yaml.gsub!(/Calculation/, 'Somerubbish')
        new_compressed_data = Zlib::Deflate.deflate(original_yaml).to_yaml
        data.replace(new_compressed_data)
        # Act - Try and find it
        result = repo.find

        # Assert - make sure its a new one
        expect(result.inputs).to have_attributes to_hash: {}
      end

      it 'returns a new empty instance if the value is from before we started compressing' do
        # Arrange - Store a value and modify it as we have access to the store
        original = Calculation.new(inputs: { marital_status: 'single' }, available_help: :undecided)
        repo.save(original)
        data = store.values.last
        original_yaml = Zlib::Inflate.inflate(YAML.safe_load(data))
        data.replace(original_yaml)
        # Act - Try and find it
        result = repo.find

        # Assert - make sure its a new one
        expect(result.inputs).to have_attributes to_hash: {}
      end

      it 'freezes the calculation if the saved version is frozen' do
        # Arrange - save a frozen calculation
        calc = repo.find
        calc.freeze
        repo.save calc

        # Act - Find it
        result = repo.find

        # Assert - make sure the found calculation is frozen
        expect(result).to be_a(Calculation).and(be_frozen)

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
