require 'rails_helper'
RSpec.describe CalculationService do
  subject(:service) { described_class }

  # The fake calculators that are used by most examples.
  # As standard, we setup 3 calculators but this is just an arbitrary number.
  # The service can handle any number of calculators
  shared_context 'with fake calculators' do
    let(:calculator_1_class) { class_spy(BaseCalculatorService, 'Calculator 1 class', identifier: :calculator1) }
    let(:calculator_2_class) { class_spy(BaseCalculatorService, 'Calculator 2 class', identifier: :calculator2) }
    let(:calculator_3_class) { class_spy(BaseCalculatorService, 'Calculator 3 class', identifier: :calculator3) }

    let(:calculator_1) do
      instance_spy(BaseCalculatorService, 'Calculator 1', available_help: :undecided, valid?: true, messages: [], remission: 0.0, final_decision?: false)
    end

    let(:calculator_2) do
      instance_spy(BaseCalculatorService, 'Calculator 2', available_help: :undecided, valid?: true, messages: [], remission: 0.0, final_decision?: false)
    end

    let(:calculator_3) do
      instance_spy(BaseCalculatorService, 'Calculator 3', available_help: :undecided, valid?: true, messages: [], remission: 0.0, final_decision?: false)
    end

    let(:calculators) { [calculator_1_class, calculator_2_class, calculator_3_class] }

    # The calculators must be called using the simple call method on the class
    # Whilst an instance can be created and the call method used on that, it is
    # preferred that we don't do this.
    before do
      allow(calculator_1_class).to receive(:call).with(instance_of(Hash)).and_return(calculator_1)
      allow(calculator_2_class).to receive(:call).with(instance_of(Hash)).and_return(calculator_2)
      allow(calculator_3_class).to receive(:call).with(instance_of(Hash)).and_return(calculator_3)
    end
  end

  describe '#call' do
    context 'with fake calculators' do
      let(:calculation) { Calculation.new inputs: { disposable_capital: 500.0, marital_status: 'single' } }
      let(:inputs) do
        {
          disposable_capital: 1000.0
        }
      end

      include_context 'with fake calculators'
      it 'calls calculator 1' do
        # Act
        service.call(inputs, calculation, calculators: calculators)

        # Assert
        expect(calculator_1_class).to have_received(:call).with(instance_of(Hash))
      end

      it 'calls calculator 2' do
        # Act
        service.call(inputs, calculation, calculators: calculators)

        # Assert
        expect(calculator_2_class).to have_received(:call).with(instance_of(Hash))
      end

      it 'calls calculator 3' do
        # Act
        service.call(inputs, calculation, calculators: calculators)

        # Assert
        expect(calculator_3_class).to have_received(:call).with(instance_of(Hash))
      end

      it 'calls the calculators with the merged inputs' do
        # Act
        service.call(inputs, calculation, calculators: calculators)

        # Assert
        aggregate_failures 'validating all 3 calculator inputs' do
          expect(calculator_3_class).to have_received(:call).with(disposable_capital: 1000.0, marital_status: 'single')
        end

      end

      it 'returns an instance of CalculationService' do
        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators)).to be_a described_class
      end

      context 'with calculation failures' do
        it 'prevents calculator 2 being called if calculator 1 fails' do
          # Arrange
          failure_reasons = [:reason1, :reason2]
          allow(calculator_1).to receive(:available_help).and_return :none
          allow(calculator_1).to receive(:messages).and_return failure_reasons

          # Act
          service.call(inputs, calculation, calculators: calculators)

          # Assert
          expect(calculator_2_class).not_to(have_received(:call))
        end

        it 'prevents calculator 3 being called if calculator 1 fails' do
          # Act
          failure_reasons = [:reason1, :reason2]
          allow(calculator_1).to receive(:available_help).and_return :none
          allow(calculator_1).to receive(:messages).and_return failure_reasons

          # Arrange
          service.call(inputs, calculation, calculators: calculators)

          # Assert
          expect(calculator_3_class).not_to(have_received(:call))
        end
      end

      context 'with order of calculators called validation' do
        let(:calculators_called) { [] }

        before do
          allow(calculator_1_class).to receive(:call).with(instance_of(Hash)) do
            calculators_called << 1
            calculator_1
          end
          allow(calculator_2_class).to receive(:call).with(instance_of(Hash)) do
            calculators_called << 2
            calculator_2
          end
          allow(calculator_3_class).to receive(:call).with(instance_of(Hash)) do
            calculators_called << 3
            calculator_3
          end
        end
        it 'calls the calculators in order' do
          # Act
          service.call(inputs, calculation, calculators: calculators)

          # Assert
          expect(calculators_called).to eql [1, 2, 3]
        end

        it 'does not call the second calculator if the first had invalid inputs' do
          # Arrange
          allow(calculator_1_class).to receive(:call).with(instance_of(Hash)) do
            calculators_called << 1
            allow(calculator_1).to receive(:valid?).and_return false
            throw :invalid_inputs, calculator_1
          end

          # Act
          service.call(inputs, calculation, calculators: calculators)

          # Assert
          expect(calculators_called).to eql [1]
        end
      end
    end

    context 'with pre configured calculators' do
      let(:calculation) { Calculation.new }
      let(:inputs) do
        {
          disposable_capital: 1000,
          benefits_received: ['benefit_1']
        }
      end

      before do
        fake_calculation = instance_double(BaseCalculatorService, 'Fake calculation', available_help: :undecided, valid?: true, remission: 0.0, final_decision?: false, messages: [])
        class_double(BenefitsReceivedCalculatorService, identifier: :benefits_received, call: fake_calculation, fields_required: []).as_stubbed_const
        class_double(HouseholdIncomeCalculatorService, identifier: :household_income, call: fake_calculation, fields_required: []).as_stubbed_const
        class_double(DisposableCapitalCalculatorService, identifier: :disposable_capital, call: fake_calculation, fields_required: []).as_stubbed_const
      end

      it 'calls the disposable income calculator' do
        # Act
        service.call(inputs, calculation)

        # Assert
        expect(DisposableCapitalCalculatorService).to have_received(:call).with(inputs)
      end

      it 'calls the benefits received calculator' do
        # Act
        service.call(inputs, calculation)

        # Assert
        expect(BenefitsReceivedCalculatorService).to have_received(:call).with(inputs)
      end

      it 'calls the household income calculator' do
        # Act
        service.call(inputs, calculation)

        # Assert
        expect(HouseholdIncomeCalculatorService).to have_received(:call).with(inputs)
      end
    end
  end

  describe '#result' do
    let(:calculation) { Calculation.new }

    describe '#available_help' do
      let(:inputs) do
        {
          disposable_capital: 1000
        }
      end

      include_context 'with fake calculators'

      it 'has help available if calculator 1 says it is available' do
        # Arrange
        allow(calculator_1).to receive(:available_help).and_return :full
        allow(calculator_1).to receive(:messages).and_return []
        allow(calculator_1).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes available_help: :full
      end

      it 'has partial help available if calculator 1 says it is available' do
        # Arrange
        allow(calculator_1).to receive(:available_help).and_return :partial
        allow(calculator_1).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes available_help: :partial
      end

      it 'has undecided help available if calculator 1 says its available' do
        # Arrange
        allow(calculator_1).to receive(:available_help).and_return :undecided
        allow(calculator_1).to receive(:final_decision?).and_return false

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes available_help: :undecided

      end

      it 'has undecided help available if calculator 2 says it is available overriding calculator 1' do
        # Arrange
        allow(calculator_1).to receive(:available_help).and_return :full
        allow(calculator_2).to receive(:available_help).and_return :undecided

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes available_help: :undecided
      end

      it 'returns true if available_help returns :none from fake calculator' do
        # Arrange
        allow(calculator_1).to receive(:available_help).and_return :none
        allow(calculator_1).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes available_help: :none
      end

      it 'provides access to messages' do
        # Arrange
        reasons = [:reason1, :reason2]
        allow(calculator_1).to receive(:available_help).and_return :full
        allow(calculator_1).to receive(:messages).and_return reasons

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes messages: reasons
      end
    end

    describe '#remission' do
      let(:inputs) do
        {
          disposable_capital: 1000
        }
      end

      include_context 'with fake calculators'

      it 'returns the value from calculator 1' do
        # Arrange
        allow(calculator_1).to receive(:available_help).and_return :partial
        allow(calculator_1).to receive(:remission).and_return 100.0

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes remission: 100.0
      end
    end

    describe '#fields_required' do
      let(:inputs) do
        {
          disposable_capital: 1000
        }
      end

      include_context 'with fake calculators'
      before do
        # Arrange - Each calculator class can tell us which fields are required based on inputs
        # Here we just give some dummy data - it is not relevant as long as they all get added together in the correct order
        allow(calculator_1_class).to receive(:fields_required).with(inputs).and_return([:fee])
        allow(calculator_2_class).to receive(:fields_required).with(inputs).and_return([:date_of_birth, :benefits_received])
        allow(calculator_3_class).to receive(:fields_required).with(inputs).and_return([:number_of_children, :total_income])
      end

      it 'returns any fields not provided in the input in the correct order prefixed with marital_status' do

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes fields_required: [:marital_status, :fee, :date_of_birth, :benefits_received, :number_of_children, :total_income]
      end

      it 'calls fields_required on calculator 1 class' do
        # Act and Assert
        service.call(inputs, calculation, calculators: calculators).result.fields_required
        expect(calculator_1_class).to have_received(:fields_required).with(inputs)
      end

      it 'calls fields_required on calculator 2 class' do
        # Act and Assert
        service.call(inputs, calculation, calculators: calculators).result.fields_required
        expect(calculator_2_class).to have_received(:fields_required).with(inputs)
      end

      it 'calls fields_required on calculator 3 class' do
        # Act and Assert
        service.call(inputs, calculation, calculators: calculators).result.fields_required
        expect(calculator_3_class).to have_received(:fields_required).with(inputs)
      end
    end

    describe 'final_decision_by' do
      let(:inputs) do
        {
          disposable_capital: 1000
        }
      end

      include_context 'with fake calculators'

      it 'is :calculator1 if calculator 1 makes a final positive decision' do
        # Arrange

        allow(calculator_1).to receive(:available_help).and_return :full
        allow(calculator_1).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :calculator1
      end

      it 'is :calculator2 if calculator 2 makes a final positive decision' do
        # Arrange
        allow(calculator_2).to receive(:available_help).and_return :full
        allow(calculator_2).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :calculator2
      end

      it 'is :calculator3 if calculator 3 makes a final positive decision' do
        # Arrange
        allow(calculator_3).to receive(:available_help).and_return :full
        allow(calculator_3).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :calculator3
      end

      it 'is :calculator1 if calculator 1 makes a negative decision' do
        # Arrange

        allow(calculator_1).to receive(:available_help).and_return :none
        allow(calculator_1).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :calculator1
      end

      it 'is :calculator2 if calculator 2 makes a final negative decision' do
        # Arrange
        allow(calculator_2).to receive(:available_help).and_return :none
        allow(calculator_2).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :calculator2
      end

      it 'is :calculator3 if calculator 3 makes a final negative decision' do
        # Arrange
        allow(calculator_3).to receive(:available_help).and_return :none
        allow(calculator_3).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :calculator3
      end

      it 'is :none if no calculators have made a final decision' do
        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_by: :none
      end
    end

    describe 'final_decision_made?' do
      let(:inputs) do
        {
          disposable_capital: 1000
        }
      end

      include_context 'with fake calculators'

      it 'is true if calculator 1 makes a final positive decision' do
        # Arrange

        allow(calculator_1).to receive(:available_help).and_return :full
        allow(calculator_1).to receive(:final_decision?).and_return true

        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_made?: true
      end

      it 'is false if no calculators have made a final decision' do
        # Act and Assert
        expect(service.call(inputs, calculation, calculators: calculators).result).to have_attributes final_decision_made?: false
      end
    end
  end
end
