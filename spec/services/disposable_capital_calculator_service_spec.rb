require 'rails_helper'
RSpec.describe DisposableCapitalCalculatorService do
  subject(:service) { described_class }

  describe '#call' do
    shared_examples 'disposable_capital_limited_to' do |age:, partner_age: nil, fee:, limit:|
      next_to_limit = limit - 1

      context "age: #{age}, partner_age: #{partner_age}, fee: #{fee}" do
        date_of_birth = (age.years.ago - 1.day).to_date
        partner_date_of_birth = partner_age.nil? ? nil : (partner_age.years.ago - 1.day).to_date
        it "states help is available when disposable_capital: 0" do
          expect(service.call(date_of_birth: date_of_birth, partner_date_of_birth: partner_date_of_birth, fee: fee, disposable_capital: 0)).to have_attributes available_help: :full, messages: a_collection_including(a_hash_including(key: :likely, source: :disposable_capital)), final_decision?: false
        end

        it "states help is available when disposable_capital: 1" do
          expect(service.call(date_of_birth: date_of_birth, partner_date_of_birth: partner_date_of_birth, fee: fee, disposable_capital: 1)).to have_attributes available_help: :full, messages: a_collection_including(a_hash_including(key: :likely, source: :disposable_capital)), final_decision?: false
        end

        it "states help is available when disposable_capital: #{next_to_limit}" do
          expect(service.call(date_of_birth: date_of_birth, partner_date_of_birth: partner_date_of_birth, fee: fee, disposable_capital: next_to_limit)).to have_attributes available_help: :full, messages: a_collection_including(a_hash_including(key: :likely, source: :disposable_capital)), final_decision?: false
        end

        it "states help is not available when disposable_capital: #{limit}" do
          expect(service.call(date_of_birth: date_of_birth, partner_date_of_birth: partner_date_of_birth, fee: fee, disposable_capital: limit)).to have_attributes available_help: :none, messages: a_collection_including(a_hash_including(key: :final_negative, source: :disposable_capital)), final_decision?: true
        end

        it "states help is not available when disposable_capital: #{limit + 1}" do
          expect(service.call(date_of_birth: date_of_birth, partner_date_of_birth: partner_date_of_birth, fee: fee, disposable_capital: limit + 1)).to have_attributes available_help: :none, messages: a_collection_including(a_hash_including(key: :final_negative, source: :disposable_capital)), final_decision?: true
        end

        it "states help is not available when disposable_capital: #{limit + 100000}" do
          expect(service.call(date_of_birth: date_of_birth, partner_date_of_birth: partner_date_of_birth, fee: fee, disposable_capital: limit + 100000)).to have_attributes available_help: :none, messages: a_collection_including(a_hash_including(key: :final_negative, source: :disposable_capital)), final_decision?: true
        end
      end
    end
    [[1, nil], [60, nil], [60, 61], [61, 60], [59, 61], [61, 59]].each do |(age, partner_age)|
      context "age: #{age}, partner_age: #{partner_age}" do
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1, limit: 3000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 500, limit: 3000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 999, limit: 3000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1000, limit: 3000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1001, limit: 4000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1334, limit: 4000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1335, limit: 4000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1336, limit: 5000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1500, limit: 5000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1664, limit: 5000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1665, limit: 5000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1666, limit: 6000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1800, limit: 6000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1999, limit: 6000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 2000, limit: 6000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 2001, limit: 7000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 2150, limit: 7000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 2329, limit: 7000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 2330, limit: 7000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 2331, limit: 8000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 3000, limit: 8000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 3999, limit: 8000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 4000, limit: 8000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 4001, limit: 10000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 4500, limit: 10000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 4999, limit: 10000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 5000, limit: 10000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 5001, limit: 12000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 5500, limit: 12000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 5999, limit: 12000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 6000, limit: 12000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 6001, limit: 14000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 6500, limit: 14000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 6999, limit: 14000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 7000, limit: 14000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 7001, limit: 16000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 10000, limit: 16000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1000000000000, limit: 16000
      end
    end
    [[61, nil], [62, nil], [99, nil], [61, 61], [62, 62], [61, 75]].each do |(age, partner_age)|
      context "age #{age}, partner_age: #{partner_age}" do
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1, limit: 16000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 10, limit: 16000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 100, limit: 16000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1000, limit: 16000
        include_examples 'disposable_capital_limited_to', age: age, partner_age: partner_age, fee: 1000000000000, limit: 16000
      end
    end

    it 'throws :invalid_inputs if not valid' do
      expect { service.call(date_of_birth: nil, fee: 100, disposable_capital: 1000) }.to throw_symbol(:invalid_inputs)
    end

    it 'throws :invalid_inputs with an instance that is invalid' do
      result = catch(:invalid_inputs) do
        service.call(date_of_birth: nil, fee: 100, disposable_capital: 1000)
      end
      expect(result).to be_a(described_class).and(an_object_having_attributes(valid?: false))
    end

    # The age service has it's own tests to verify things like feb 29th birthdays etc..
    it 'uses the AgeService' do
      age_service = class_spy('AgeService').as_stubbed_const
      allow(age_service).to receive(:call).and_return(30) # Irrelevant response
      service.call(date_of_birth: Date.parse('29 February 1996'), fee: 100, disposable_capital: 10000)
      expect(age_service).to have_received(:call).with(date_of_birth: Date.parse('29 February 1996'))
    end

    it 'uses the AgeService with the youngest of the 2 date of births' do
      age_service = class_spy('AgeService').as_stubbed_const
      allow(age_service).to receive(:call).and_return(30) # Irrelevant response
      service.call date_of_birth: Date.parse('29 February 1996'),
                   partner_date_of_birth: Date.parse('28 February 1996'),
                   fee: 100, disposable_capital: 10000
      expect(age_service).to have_received(:call).with(date_of_birth: Date.parse('29 February 1996'))
    end
  end

  describe '#valid?' do
    it 'is true when all inputs required are present and correct type with partner dob as nil' do
      instance = service.new(date_of_birth: 20.years.ago.to_date, partner_date_of_birth: nil, fee: 1000, disposable_capital: 100)
      expect(instance.valid?).to be true
    end

    it 'is true when all inputs required are present and correct type with partner dob as date' do
      instance = service.new(date_of_birth: 20.years.ago.to_date, partner_date_of_birth: 18.years.ago.to_date, fee: 1000, disposable_capital: 100)
      expect(instance.valid?).to be true
    end

    it 'is false when all inputs required are present but one is of incorrect type' do
      instance = service.new(date_of_birth: "31 December 2017", partner_date_of_birth: nil, fee: 1000, disposable_capital: 100)
      expect(instance.valid?).to be false
    end

    it 'is false when all inputs required are present but one is nil' do
      instance = service.new(date_of_birth: nil, partner_date_of_birth: nil, fee: 1000, disposable_capital: 100)
      expect(instance.valid?).to be false
    end

    it 'is false when one input is missing' do
      instance = service.new(fee: 1000, disposable_capital: 100, partner_date_of_birth: nil)
      expect(instance.valid?).to be false
    end

    it 'is false when all inputs are missing' do
      instance = service.new({})
      expect(instance.valid?).to be false
    end
  end
end
