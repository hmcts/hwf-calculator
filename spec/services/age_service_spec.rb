require 'rails_helper'
RSpec.describe AgeService do
  describe '#call' do
    it 'returns 1 for 1.year.ago' do
      # Arrange
      date = 1.year.ago.to_date

      # Act
      result = described_class.call(date_of_birth: date)

      # Assert
      expect(result).to be 1
    end

    it 'returns 1 for 2 years ago minus 1 second' do
      # Arrange
      date = (2.years.ago.midnight + 1.day).to_date

      # Act
      result = described_class.call(date_of_birth: date)

      # Assert
      expect(result).to be 1
    end

    it 'returns 2 years for 2 years ago' do
      # Arrange
      date = 2.years.ago.to_date

      # Act
      result = described_class.call(date_of_birth: date)

      # Assert
      expect(result).to be 2
    end

    it 'returns the difference between 2 dates in years when second date is given as from:' do
      # Arrange
      date1 = Date.parse('1 January 2014')
      date2 = Date.parse('1 January 2017')

      # Act
      result = described_class.call(date_of_birth: date1, from: date2)

      # Assert
      expect(result).to be 3
    end

    # From here, we have proven the from: date is assumed to be Time.now.midnight.to_date
    # so we will test everything with injected values for :from from now on

    it 'returns 1 year less if we are the day before their birthday' do
      # Arrange
      date1 = Date.parse('10 January 2014')
      date2 = Date.parse('9 January 2017')

      # Act
      result = described_class.call(date_of_birth: date1, from: date2)

      # Assert
      expect(result).to be 2
    end

    it 'returns the difference in years if we are on their birthday' do
      # Arrange
      date1 = Date.parse('10 January 2014')
      date2 = Date.parse('10 January 2017')

      # Act
      result = described_class.call(date_of_birth: date1, from: date2)

      # Assert
      expect(result).to be 3
    end

    it 'returns the difference in years if we are one day after their birthday' do
      # Arrange
      date1 = Date.parse('10 January 2014')
      date2 = Date.parse('11 January 2017')

      # Act
      result = described_class.call(date_of_birth: date1, from: date2)

      # Assert
      expect(result).to be 3
    end

    context 'when born on leap day' do
      it 'returns the difference in years if we are on their birthday in another leap year' do
        # Arrange
        date1 = Date.parse('29 February 1996')
        date2 = Date.parse('29 February 2016')

        # Act
        result = described_class.call(date_of_birth: date1, from: date2)

        # Assert
        expect(result).to be 20
      end

      it 'returns the difference in years minus 1 if we are on the 28th february in another year' do
        # Arrange
        date1 = Date.parse('29 February 1996')
        date2 = Date.parse('28 February 2015')

        # Act
        result = described_class.call(date_of_birth: date1, from: date2)

        # Assert
        expect(result).to be 18
      end

      it 'returns the difference in years if we are on the 1st march in another year' do
        # Arrange
        date1 = Date.parse('29 February 1996')
        date2 = Date.parse('1 March 2015')

        # Act
        result = described_class.call(date_of_birth: date1, from: date2)

        # Assert
        expect(result).to be 19
      end

      it 'returns the difference in years if we are on the 2nd march in another year' do
        # Arrange
        date1 = Date.parse('29 February 1996')
        date2 = Date.parse('2 March 2015')

        # Act
        result = described_class.call(date_of_birth: date1, from: date2)

        # Assert
        expect(result).to be 19
      end
    end
  end
end
