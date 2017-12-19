require 'rails_helper'
RSpec.describe DateOfBirthForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :date_of_birth' do
      expect(form.type).to be :date_of_birth
    end
  end

  describe '#initialize' do
    it 'converts from rails 1i, 2i, 3i format from date helpers' do
      subject = described_class.new('date_of_birth(1i)' => '2000', 'date_of_birth(2i)' => '12', 'date_of_birth(3i)' => '27')
      expect(subject.date_of_birth).to eql(Date.new(2000, 12, 27))
    end
  end

  describe '#export' do
    it 'exports the date_of_birth' do
      form.date_of_birth = Date.new(2000, 1, 1)
      expect(form.export).to eql date_of_birth: Date.new(2000, 1, 1)
    end
  end
end
