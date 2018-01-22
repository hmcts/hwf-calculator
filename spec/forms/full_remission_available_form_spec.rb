require 'rails_helper'
RSpec.describe FullRemissionAvailableForm, type: :model do
  subject(:form) { described_class.new }

  describe 'type' do
    it 'returns "full_remission_available"' do
      expect(described_class.type).to be :full_remission_available
    end
  end

  describe '#export' do
    it 'exports an empty hash' do
      expect(form.export).to(be_empty.and(be_a(Hash)))
    end
  end
end
