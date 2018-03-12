require 'rails_helper'
RSpec.describe HouseholdIncomeCalculatorService do
  subject(:service) { described_class }

  # First, some common parameters for all tests
  let(:minimum_threshold_hash) { { single: 1085.0, sharing_income: 1245.0 } }
  let(:maximum_threshold_hash) { { single: 5085.0, sharing_income: 5245.0 } }
  let(:child_allowance) { 245 }
  let(:fee) { 4000.0 }

  describe '#valid?' do
    it 'is true if all inputs are present and the correct type' do
      instance = service.new(total_income: 1000.0, marital_status: 'single', number_of_children: 0, fee: 0.0)
      expect(instance.valid?).to be true
    end

    it 'is false if one input is missing' do
      instance = service.new(marital_status: 'single', number_of_children: 0)
      expect(instance.valid?).to be false
    end

    it 'is false if all inputs are missing' do
      instance = service.new({})
      expect(instance.valid?).to be false
    end

    it 'is false if total_income is an integer' do
      instance = service.new(total_income: 1000, marital_status: 'single', number_of_children: 0)
      expect(instance.valid?).to be false
    end

    it 'is false if total_income is a string' do
      instance = service.new(total_income: '1000', marital_status: 'single', number_of_children: 0)
      expect(instance.valid?).to be false
    end

    it 'is false if marital_status is something other than single or sharing_income' do
      instance = service.new(total_income: 1000, marital_status: 'something_wrong', number_of_children: 0)
      expect(instance.valid?).to be false
    end

    it 'is false if number_of_children is a float' do
      instance = service.new(total_income: 1000.0, marital_status: 'single', number_of_children: 0.0)
      expect(instance.valid?).to be false
    end

    it 'is false if number_of_children is a string' do
      instance = service.new(total_income: 1000.0, marital_status: 'single', number_of_children: '0')
      expect(instance.valid?).to be false
    end
  end

  describe '#call' do
    # Rules:
    #
    # - For every £10 of gross monthly income received above the threshold, citizen must pay £5 towards the fee
    # - For Part remission, the figure is rounded down to the nearest £10
    # - Income test is subject to Citizen passing the Disposable Capital test
    # - Citizen may be eligible for full remission if their monthly income is less than the minimum threshold (Single:£1,085 & Couple: £1,245) plus £245 for each child that they have
    # - Citizen may be eligible for part remission if their monthly income is more than the minimum threshold (see above minimum threshold amount) but less than the maximum threshold (Single:£5,085 & Couple: £5,245) plus £245 for each child that they have
    # - Citizen will not be eligible for fee remission and will be required to pay the full court or tribunal fee if their monthly income is over the maximum threshold (see above maximum threshold amount)
    let(:minimum_threshold) { minimum_threshold_hash[marital_status] + (child_allowance * children) }
    let(:maximum_threshold) { maximum_threshold_hash[marital_status] + (child_allowance * children) }

    context 'with full remission' do
      shared_examples 'full remission' do
        it 'returns full remission if monthly income is less than threshold' do
          # Arrange
          income = minimum_threshold - 1.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :full
        end

        it 'returns full remission if monthly income is equal to the threshold' do
          # Arrange
          income = minimum_threshold

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :full
        end

        it 'returns full remission if monthly income is just over the threshold by £9' do
          # Arrange
          income = minimum_threshold + 9.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :full
        end
      end

      context 'when single, no children' do
        let(:children) { 0 }
        let(:marital_status) { :single }

        include_examples 'full remission'
      end

      context 'when single, 1 child' do
        let(:children) { 1 }
        let(:marital_status) { :single }

        include_examples 'full remission'
      end

      context 'when single, 2 children' do
        let(:children) { 1 }
        let(:marital_status) { :single }

        include_examples 'full remission'
      end

      context 'when married, no children' do
        let(:children) { 0 }
        let(:marital_status) { :sharing_income }

        include_examples 'full remission'
      end

      context 'when married, 1 child' do
        let(:children) { 1 }
        let(:marital_status) { :sharing_income }

        include_examples 'full remission'
      end

      context 'when married, 2 children' do
        let(:children) { 2 }
        let(:marital_status) { :sharing_income }

        include_examples 'full remission'
      end
    end

    context 'with partial remission' do
      shared_examples 'partial remission' do
        it 'returns part remission of the full fee minus 5 pounds if monthly income is over the minimum by 10 pounds' do
          # Arrange
          income = minimum_threshold + 10.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes remission: fee - 5.0
        end

        it 'returns part remission of the full fee minus 25 pounds if monthly income is over the minimum by 50 pounds' do
          # Arrange
          income = minimum_threshold + 50.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes remission: fee - 25
        end

        it 'returns part remission if monthly income is over the minimum threshold and just below the maximum' do
          # Arrange
          income = maximum_threshold - 1.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :partial
        end

        it 'returns part remission if monthly income is over the minimum threshold and equal to the maximum' do
          # Arrange
          income = maximum_threshold

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :partial
        end
      end

      context 'when single, no children' do
        let(:children) { 0 }
        let(:marital_status) { :single }

        include_examples 'partial remission'
      end

      context 'when single, 1 child' do
        let(:children) { 1 }
        let(:marital_status) { :single }

        include_examples 'partial remission'
      end

      context 'when single, 2 children' do
        let(:children) { 2 }
        let(:marital_status) { :single }

        include_examples 'partial remission'
      end

      context 'when married, no children' do
        let(:children) { 0 }
        let(:marital_status) { :sharing_income }

        include_examples 'partial remission'
      end

      context 'when married, 1 child' do
        let(:children) { 1 }
        let(:marital_status) { :sharing_income }

        include_examples 'partial remission'
      end

      context 'when married, 2 children' do
        let(:children) { 2 }
        let(:marital_status) { :sharing_income }

        include_examples 'partial remission'
      end
    end

    context 'with no remission' do
      shared_examples 'no remission' do
        it 'returns no remission if monthly income is over the minimum threshold and above the maximum' do
          # Arrange
          income = maximum_threshold + 1.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :none
        end

        it 'returns zero if the remission would have gone negative' do
          # Arrange - So that the user would have to pay more than the fee  according to the rules
          fee = 1000.0
          income = minimum_threshold + 2100.0

          # Act
          result = service.call(marital_status: marital_status.to_s, total_income: income, number_of_children: children, fee: fee)

          # Assert
          expect(result).to have_attributes available_help: :none
        end
      end

      context 'when single, no children' do
        let(:children) { 0 }
        let(:marital_status) { :single }

        include_examples 'no remission'
      end

      context 'when single, 1 child' do
        let(:children) { 1 }
        let(:marital_status) { :single }

        include_examples 'no remission'
      end

      context 'when single, 2 children' do
        let(:children) { 2 }
        let(:marital_status) { :single }

        include_examples 'no remission'
      end

      context 'when married, no children' do
        let(:children) { 0 }
        let(:marital_status) { :sharing_income }

        include_examples 'no remission'
      end

      context 'when married, 1 child' do
        let(:children) { 1 }
        let(:marital_status) { :sharing_income }

        include_examples 'no remission'
      end

      context 'when married, 2 children' do
        let(:children) { 2 }
        let(:marital_status) { :sharing_income }

        include_examples 'no remission'
      end
    end
  end
end
