require 'rails_helper'
RSpec.describe AgeValidator do
  context 'when age greater than or equal to 16' do
    # As the validator interface is not ours, it belongs to active model,
    # then use the validator as it is supposed to be used in a test class
    # and test the functionality from there.
    let(:model_class) do
      svc = age_service
      Class.new do
        include ActiveModel::Model
        attr_accessor :date

        def self.name
          'MyModel'
        end

        validates :date, age: { greater_than_or_equal_to: 16, age_service: svc }
      end
    end

    # The age validator must use the age service as it allows for birthdays on leap days etc..
    let(:age_service) { class_spy('AgeService', call: age) }

    context 'with the age service returning 15' do
      let(:age) { 15 }

      it 'disallows the 15 year old' do
        # Arrange
        model = model_class.new(date: Time.zone.today)

        # Act
        model.valid?

        # Assert
        expect(model.errors.details[:date]).to contain_exactly a_hash_including(error: :age_less_than, count: 16)
      end
    end

    context 'with the age service returning 16' do
      let(:age) { 16 }

      it 'allows the 16 year old' do
        # Arrange
        model = model_class.new(date: Time.zone.today)

        # Act
        model.valid?

        # Assert
        expect(model.errors.details[:date]).to be_empty
      end
    end

    context 'with the age service returning 17' do
      let(:age) { 17 }

      it 'allows the 16 year old' do
        # Arrange
        model = model_class.new(date: Time.zone.today)

        # Act
        model.valid?

        # Assert
        expect(model.errors.details[:date]).to be_empty
      end
    end
  end
end
