require 'rails_helper'
RSpec.describe TotalIncomeForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    describe 'disposable_capital' do
      it 'allows numeric values' do
        # Arrange
        form.total_income = '10000'

        # Act
        form.valid?

        # Assert
        expect(form.errors).not_to include :total_income
      end

      it 'disallows blank' do
        # Arrange
        form.total_income = ''

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :blank)
      end

      it 'disallows negative values' do
        # Arrange
        form.total_income = '-100'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :greater_than_or_equal_to, count: 0)
      end

      it 'disallows floating point numbers' do
        # Arrange
        form.total_income = '1000.00'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :not_an_integer)
      end

      it 'disallows non numeric values' do
        # Arrange
        form.total_income = 'dddd'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :not_a_number)
      end

      it 'disallows NaN for security measures' do
        # Arrange
        form.total_income = 'NaN'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :not_a_number)
      end

      it 'disallows Infinity for security measures' do
        # Arrange
        form.total_income = 'Infinity'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :not_a_number)
      end

      it 'disallows -Infinity for security measures' do
        # Arrange
        form.total_income = '-Infinity'

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:total_income]).to contain_exactly a_hash_including(error: :not_a_number)
      end
    end
  end

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(total_income: '1000', some_other_field: 12)
      expect(subject.total_income).to be 1000
    end
  end

  describe 'type' do
    it 'returns :total_income' do
      expect(described_class.type).to be :total_income
    end
  end

  describe '#export' do
    it 'exports the total income' do
      form.total_income = '10000'
      expect(form.export).to eql(total_income: 10000.0)
    end
  end

  describe 'attribute?' do
    it 'returns true for :total_income' do
      expect(described_class.attribute?(:total_income)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.attribute?(:a_wrong_field)).to be false
    end
  end
end
