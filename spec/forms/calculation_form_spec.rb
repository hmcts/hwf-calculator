require 'rails_helper'
RSpec.describe CalculationForm do
  describe '#export' do
    it 'is empty with empty inputs' do
      form = described_class.new({})
      expect(form.export).to be_empty
    end

    it 'is only has one key when only 1 key is given in the output' do
      form = described_class.new(fee: 10)
      expect(form.export.keys).to contain_exactly(:fee)
    end

    it 'is only has two keys when only 2 keys are given in the output' do
      form = described_class.new(fee: 10, disposable_capital: 1000)
      expect(form.export.keys).to contain_exactly(:fee, :disposable_capital)
    end
  end

  describe '#date_of_birth=' do
    it 'persists as a date' do
      form = described_class.new({})
      form.date_of_birth = '1999-12-27'
      expect(form.date_of_birth).to eql Date.parse('27 December 1999')
    end
  end

  describe '#date_of_birth via initialize' do
    it 'persists as a date' do
      form = described_class.new(date_of_birth: '1999-12-27')
      expect(form.date_of_birth).to eql Date.parse('27 December 1999')
    end
  end

  describe '#fee=' do
    it 'persists as a float' do
      form = described_class.new({})
      form.fee = '10'
      expect(form.fee).to be 10.0
    end
  end

  describe '#fee= via initialize' do
    it 'persists as a float' do
      form = described_class.new(fee: '10')
      expect(form.fee).to be 10.0
    end
  end

  describe '#disposable_capital=' do
    it 'persists as a float' do
      form = described_class.new({})
      form.disposable_capital = '10000'
      expect(form.disposable_capital).to be 10000.0
    end
  end

  describe '#disposable_capital= via initialize' do
    it 'persists as a float' do
      form = described_class.new(disposable_capital: '10000')
      expect(form.disposable_capital).to be 10000.0
    end
  end

  describe '#marital_status=' do
    it 'persists as a float' do
      form = described_class.new({})
      form.marital_status = 'sharing_income'
      expect(form.marital_status).to eql 'sharing_income'
    end
  end

  describe '#marital_status= via initialize' do
    it 'persists as a float' do
      form = described_class.new(marital_status: 'sharing_income')
      expect(form.marital_status).to eql 'sharing_income'
    end
  end

  describe "#benefits_received=" do
    it 'persists as an array' do
      form = described_class.new({})
      form.benefits_received = [:jobseekers_allowance]
      expect(form.benefits_received).to eql [:jobseekers_allowance]
    end
  end

  describe "benefits_received= via initialize" do
    it 'persists as an array' do
      form = described_class.new(benefits_received: [:jobseekers_allowance])
      expect(form.benefits_received).to eql [:jobseekers_allowance]
    end
  end

  describe "number_of_children=" do
    it 'persists as number' do
      form = described_class.new({})
      form.number_of_children = 10
      expect(form.number_of_children).to be 10
    end
  end

  describe 'number_of_children= via initialize' do
    it 'persists as number' do
      form = described_class.new(number_of_children: 5)
      expect(form.number_of_children).to be 5
    end
  end

  context 'validation' do
    it 'should have validation stuff - @TODO'
  end

end
