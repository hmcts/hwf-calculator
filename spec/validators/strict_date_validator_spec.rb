require 'rails_helper'
RSpec.describe StrictDateValidator do
  context 'when age greater than or equal to 16' do
    # The validator uses the special 'InvalidDate' which we will mock our own and inject it into the validator
    class MyInvalidDate < Date

    end

    # As the validator interface is not ours, it belongs to active model,
    # then use the validator as it is supposed to be used in a test class
    # and test the functionality from there.
    let(:model_class) do
      Class.new do
        include ActiveModel::Model
        attr_accessor :date

        def self.name
          'MyModel'
        end

        validates :date, strict_date: { invalid_date_class: MyInvalidDate }
      end
    end

    context 'with an invalid date' do
      it 'disallows the invalid date' do
        # Arrange
        date = MyInvalidDate.new(1970, 1, 1)
        model = model_class.new(date: date)

        # Act
        model.valid?

        # Assert
        expect(model.errors.details[:date]).to contain_exactly a_hash_including(error: :invalid_date)
      end
    end

    context 'with a valid date' do
      it 'allows the valid date' do
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
