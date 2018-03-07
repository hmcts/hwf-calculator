require 'rails_helper'
RSpec.describe DateOfBirthForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    describe 'date_of_birth' do
      it 'disallows nil' do
        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :blank)
      end

      it 'disallows blank' do
        # Arrange
        form = described_class.new('date_of_birth' => { 'day' => '', 'month' => '', 'year' => '' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :blank)
      end

      it 'disallows someone who is just under 15' do
        # Arrange
        d = (Time.zone.tomorrow - 15.years)
        form = described_class.new('date_of_birth' => { 'year' => d.year.to_s, 'month' => d.month.to_s, 'day' => d.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :age_less_than, count: 15)
      end

      it 'allows someone who has just turned 15' do
        # Arrange
        d = Time.zone.today - 15.years
        form = described_class.new('date_of_birth' => { 'year' => d.year.to_s, 'month' => d.month.to_s, 'day' => d.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to be_empty
      end

      it 'allows someone who is 16' do
        # Arrange
        d = Time.zone.today - 16.years
        form = described_class.new('date_of_birth' => { 'year' => d.year.to_s, 'month' => d.month.to_s, 'day' => d.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to be_empty
      end

      it 'disallows someone who is 121 years old' do
        # Arrange
        dob = 121.years.ago - 1.day
        form = described_class.new('date_of_birth' => { 'year' => dob.year.to_s, 'month' => dob.month.to_s, 'day' => dob.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :age_greater_than, count: 120)
      end

      it 'disallows a non numeric month field' do
        # Arrange
        form = described_class.new('date_of_birth' => { 'year' => '1970', 'month' => 'July', 'day' => '01' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :invalid_date)
      end

      it 'disallows a non numeric day field' do
        # Arrange
        form = described_class.new('date_of_birth' => { 'year' => '1970', 'month' => '07', 'day' => 'First' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :invalid_date)
      end

      it 'disallows a non numeric year field' do
        # Arrange
        form = described_class.new('date_of_birth' => { 'year' => 'Millenium', 'month' => 'July', 'day' => '01' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:date_of_birth]).to contain_exactly a_hash_including(error: :invalid_date)
      end
    end

    describe 'partner_date_of_birth' do
      it 'allows nil' do
        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to be_empty
      end

      it 'disallows blank' do
        # Arrange
        form = described_class.new('partner_date_of_birth' => { 'year' => '', 'month' => '', 'day' => '' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to contain_exactly a_hash_including(error: :blank)
      end

      it 'disallows someone who is just under 15' do
        # Arrange
        d = (Time.zone.tomorrow - 15.years)
        form = described_class.new('partner_date_of_birth' => { 'year' => d.year.to_s, 'month' => d.month.to_s, 'day' => d.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to contain_exactly a_hash_including(error: :age_less_than, count: 15)
      end

      it 'allows someone who has just turned 15' do
        # Arrange
        d = Time.zone.today - 15.years
        form = described_class.new('partner_date_of_birth' => { 'year' => d.year.to_s, 'month' => d.month.to_s, 'day' => d.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to be_empty
      end

      it 'allows someone who is 16' do
        # Arrange
        d = Time.zone.today - 16.years
        form = described_class.new('partner_date_of_birth' => { 'year' => d.year.to_s, 'month' => d.month.to_s, 'day' => d.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to be_empty
      end

      it 'disallows someone who is 121 years old' do
        # Arrange
        dob = 121.years.ago - 1.day
        form = described_class.new('partner_date_of_birth' => { 'year' => dob.year.to_s, 'month' => dob.month.to_s, 'day' => dob.day.to_s })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to contain_exactly a_hash_including(error: :age_greater_than, count: 120)
      end

      it 'disallows a non numeric month field' do
        # Arrange
        form = described_class.new('partner_date_of_birth' => { 'year' => '1970', 'month' => 'July', 'day' => '01' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to contain_exactly a_hash_including(error: :invalid_date)
      end

      it 'disallows a non numeric day field' do
        # Arrange
        form = described_class.new('partner_date_of_birth' => { 'year' => '1970', 'month' => '07', 'day' => 'First' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to contain_exactly a_hash_including(error: :invalid_date)
      end

      it 'disallows a non numeric year field' do
        # Arrange
        form = described_class.new('partner_date_of_birth' => { 'year' => 'Millenium', 'month' => '01', 'day' => '01' })

        # Act
        form.valid?

        # Assert
        expect(form.errors.details[:partner_date_of_birth]).to contain_exactly a_hash_including(error: :invalid_date)
      end
    end
  end

  describe 'type' do
    it 'returns :date_of_birth' do
      expect(described_class.type).to be :date_of_birth
    end
  end

  describe '#initialize' do
    it 'converts date of birth from hash format' do
      subject = described_class.new('date_of_birth' => { 'year' => '2000', 'month' => '12', 'day' => '27' })
      expect(subject.date_of_birth).to eql(Date.new(2000, 12, 27))
    end

    it 'stores date of birth as is given a date' do
      subject = described_class.new(date_of_birth: Date.new(2000, 12, 27))
      expect(subject.date_of_birth).to eql(Date.new(2000, 12, 27))
    end

    it 'converts partner date of birth from hash format' do
      subject = described_class.new('partner_date_of_birth' => { 'year' => '2000', 'month' => '12', 'day' => '28' })
      expect(subject.partner_date_of_birth).to eql(Date.new(2000, 12, 28))
    end

    it 'stores partners date of birth as is given a date' do
      subject = described_class.new(partner_date_of_birth: Date.new(2000, 12, 27))
      expect(subject.partner_date_of_birth).to eql(Date.new(2000, 12, 27))
    end

    it 'allows partner date of birth fields to be nil' do
      subject = described_class.new 'date_of_birth' => { 'year' => '2000', 'month' => '12', 'day' => '27' },
                                    'partner_date_of_birth' => nil
      expect(subject.partner_date_of_birth).to be_nil
    end

    it 'allows partner date of birth field values to be nil' do
      subject = described_class.new 'date_of_birth' => { 'year' => '2000', 'month' => '12', 'day' => '27' },
                                    'partner_date_of_birth' => { 'year' => nil, 'month' => nil, 'day' => nil }
      expect(subject.partner_date_of_birth).to be_nil
    end

    it 'allows partner date of birth fields to be undefined' do
      subject = described_class.new 'date_of_birth' => { 'year' => '2000', 'month' => '12', 'day' => '27' }
      expect(subject.partner_date_of_birth).to be_nil
    end
  end

  describe 'new_ignoring_extras' do
    it 'creates a new instance without erroring if extra attributes given' do
      subject = described_class.new_ignoring_extras(partner_date_of_birth: Date.new(2000, 12, 27), some_other_field: 12)
      expect(subject.partner_date_of_birth).to eql(Date.new(2000, 12, 27))
    end
  end

  describe '#export' do
    it 'exports both date_of_birth with only 1 date provided' do
      form.date_of_birth = Date.new(2000, 1, 1)
      expect(form.export).to eql date_of_birth: Date.new(2000, 1, 1), partner_date_of_birth: nil
    end

    it 'exports both dates' do
      form.date_of_birth = Date.new(2000, 1, 1)
      form.partner_date_of_birth = Date.new(1999, 1, 1)
      expect(form.export).to eql date_of_birth: Date.new(2000, 1, 1), partner_date_of_birth: Date.new(1999, 1, 1)
    end
  end

  describe 'attribute?' do
    it 'returns true for :date_of_birth' do
      expect(described_class.attribute?(:date_of_birth)).to be true
    end

    it 'returns true for :partner_date_of_birth' do
      expect(described_class.attribute?(:partner_date_of_birth)).to be true
    end

    it 'returns false for :a_wrong_field' do
      expect(described_class.attribute?(:a_wrong_field)).to be false
    end
  end
end
