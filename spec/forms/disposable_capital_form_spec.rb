require 'rails_helper'
RSpec.describe DisposableCapitalForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    describe 'disposable_capital' do
      it 'allows numeric values' do
        # Arrange
        form.disposable_capital = '10000'

        # Act
        form.valid?

        # Assert
        expect(form.errors).not_to include :disposable_capital
      end

      it 'disallows blank' do
        # Arrange
        form.disposable_capital = ''

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :blank)
      end

      it 'disallows negative values' do
        # Arrange
        form.disposable_capital = '-100'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :greater_than_or_equal_to, count: 0)
      end

      it 'disallows floating point numbers' do
        # Arrange
        form.disposable_capital = '1000.00'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :not_an_integer)
      end

      it 'disallows non numeric values' do
        # Arrange
        form.disposable_capital = 'dddd'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :not_a_number)
      end

      it 'disallows NaN for security measures' do
        # Arrange
        form.disposable_capital = 'NaN'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :not_a_number)
      end

      it 'disallows Infinity for security measures' do
        # Arrange
        form.disposable_capital = 'Infinity'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :not_a_number)
      end

      it 'disallows -Infinity for security measures' do
        # Arrange
        form.disposable_capital = '-Infinity'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:disposable_capital]).to contain_exactly a_hash_including(error: :not_a_number)
      end
    end
  end

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(disposable_capital: '10000', some_other_field: 12)
      expect(subject.disposable_capital).to be 10000
    end
  end

  describe 'type' do
    it 'returns :disposable_capital' do
      expect(described_class.type).to be :disposable_capital
    end
  end

  describe '#export' do
    it 'exports the fee' do
      form.disposable_capital = '10000'
      expect(form.export).to eql(disposable_capital: 10000.0)
    end
  end

  describe 'has_attribute?' do
    it 'returns true for :disposable_capital' do
      expect(described_class.has_attribute?(:disposable_capital)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.has_attribute?(:a_wrong_field)).to be false
    end
  end
end
