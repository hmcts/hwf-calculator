require 'rails_helper'
RSpec.describe NilForm, type: :model do
  subject(:form) { described_class.new }

  describe 'type' do
    it 'returns "nil"' do
      expect(form.type).to be :nil
    end
  end

  describe '#export' do
    it 'exports an empty hash' do
      expect(form.export).to(be_empty.and(be_a(Hash)))
    end
  end
end
