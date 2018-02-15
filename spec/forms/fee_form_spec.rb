require 'rails_helper'
RSpec.describe FeeForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    describe 'fee' do
      it 'allows numeric values' do
        # Arrange
        form.fee = '10000'

        # Act
        form.valid?

        # Assert
        expect(form.errors).not_to include :fee
      end

      it 'disallows floating point numbers' do
        # Arrange
        form.fee = '1000.00'

        # Act
        form.valid?

        # Assert
        expect(form.errors).to include :fee
      end

      it 'disallows non numeric values' do
        # Arrange
        form.fee = 'dddd'

        # Act
        form.valid?

        # Assert
        expect(form.errors).to include :fee
      end

      it 'disallows NaN for security measures' do
        # Arrange
        form.fee = 'NaN'

        # Act
        form.valid?

        # Assert
        expect(form.errors).to include :fee
      end

      it 'disallows Infinity for security measures' do
        # Arrange
        form.fee = 'Infinity'

        # Act
        form.valid?

        # Assert
        expect(form.errors).to include :fee
      end

      it 'disallows -Infinity for security measures' do
        # Arrange
        form.fee = '-Infinity'

        # Act
        form.valid?

        # Assert
        expect(form.errors).to include :fee
      end

      it 'disallows -1' do
        # Arrange
        form.fee = '-1'

        # Act
        form.valid?

        # Assert
        expect(form.errors).to include :fee
      end
    end
  end

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(fee: '10000', some_other_field: 12)
      expect(subject.fee).to be 10000
    end
  end

  describe 'type' do
    it 'returns :fee' do
      expect(described_class.type).to be :fee
    end
  end

  describe '#export' do
    it 'exports the fee' do
      form.fee = '10000'
      expect(form.export).to eql(fee: 10000.0)
    end
  end

  describe 'attribute?' do
    it 'returns true for :fee' do
      expect(described_class.attribute?(:fee)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.attribute?(:a_wrong_field)).to be false
    end
  end
end
