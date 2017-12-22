require 'rails_helper'
RSpec.describe NumberOfChildrenForm, type: :model do
  subject(:form) { described_class.new }

  describe 'validations' do
    it 'should have some but dont know what they are yet @TODO'
  end

  describe 'type' do
    it 'returns :number_of_children' do
      expect(form.type).to be :number_of_children
    end
  end

  describe '#export' do
    it 'exports the number_of_children' do
      form.number_of_children = '2'
      expect(form.export).to eql(number_of_children: 2)
    end
  end
end
