require 'rails_helper'
RSpec.describe StrictIntegerType do
  describe '#cast' do
    subject(:type) { described_class.new }

    it 'casts integer strings to an integer' do
      expect(type.cast('10')).to be 10
    end

    it 'does not cast floats' do
      expect(type.cast('10.0')).to eql '10.0'
    end

    it 'casts integers with leading and trailing spaces to an integer' do
      expect(type.cast('   10   ')).to be 10
    end

    it 'does not case numbers with commas' do
      expect(type.cast('10,000')).to eql '10,000'
    end

    it 'does not case numbers with pound signs' do
      expect(type.cast('£10000')).to eql '£10000'
    end

    it 'does not case alphas' do
      expect(type.cast('abcdeF')).to eql 'abcdeF'
    end
  end
end
