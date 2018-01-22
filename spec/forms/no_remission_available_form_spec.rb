require 'rails_helper'
RSpec.describe NoRemissionAvailableForm, type: :model do
  subject(:form) { described_class.new }

  describe 'type' do
    it 'returns "no_remission_available"' do
      expect(described_class.type).to be :no_remission_available
    end
  end

  describe '#export' do
    it 'exports an empty hash' do
      expect(form.export).to(be_empty.and(be_a(Hash)))
    end
  end
end
