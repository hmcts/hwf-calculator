require 'rails_helper'
RSpec.describe NumberOfChildrenForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'allows numeric values' do
      # Arrange
      form.number_of_children = '2'

      # Act
      form.valid?

      # Assert
      expect(form.errors).not_to include :number_of_children
    end

    it 'disallows floating point numbers' do
      # Arrange
      form.number_of_children = '2.00'

      # Act
      form.valid?

      # Assert
      expect(form.errors).to include :number_of_children
    end

    it 'disallows non numeric values' do
      # Arrange
      form.number_of_children = 'dddd'

      # Act
      form.valid?

      # Assert
      expect(form.errors).to include :number_of_children
    end

    it 'disallows NaN for security measures' do
      # Arrange
      form.number_of_children = 'NaN'

      # Act
      form.valid?

      # Assert
      expect(form.errors).to include :number_of_children
    end

    it 'disallows Infinity for security measures' do
      # Arrange
      form.number_of_children = 'Infinity'

      # Act
      form.valid?

      # Assert
      expect(form.errors).to include :number_of_children
    end

    it 'disallows -Infinity for security measures' do
      # Arrange
      form.number_of_children = '-Infinity'

      # Act
      form.valid?

      # Assert
      expect(form.errors).to include :number_of_children
    end

    it 'disallows -1' do
      # Arrange
      form.number_of_children = '-1'

      # Act
      form.valid?

      # Assert
      expect(form.errors).to include :number_of_children
    end
  end

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(number_of_children: '2', some_other_field: 12)
      expect(subject.number_of_children).to be 2
    end
  end

  describe 'type' do
    it 'returns :number_of_children' do
      expect(described_class.type).to be :number_of_children
    end
  end

  describe '#export' do
    it 'exports the number_of_children' do
      form.number_of_children = '2'
      expect(form.export).to eql(number_of_children: 2)
    end
  end

  describe 'attribute?' do
    it 'returns true for :number_of_children' do
      expect(described_class.attribute?(:number_of_children)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.attribute?(:a_wrong_field)).to be false
    end
  end
end
