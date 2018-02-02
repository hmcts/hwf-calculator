module Calculator
  module Test
    module Pages
      def start_page
        Calculator::Test::StartPage.new
      end

      def marital_status_page
        Calculator::Test::MaritalStatusPage.new
      end

      def court_fee_page
        Calculator::Test::CourtFeePage.new
      end

      def date_of_birth_page
        Calculator::Test::DateOfBirthPage.new
      end

      def disposable_capital_page
        Calculator::Test::DisposableCapitalPage.new
      end

      # @return [Calculator::Test::NumberOfChildrenPage] The number of children page object
      def number_of_children_page
        Calculator::Test::NumberOfChildrenPage.new
      end

      # @return [Calculator::Test::IncomeBenefitsPage] The benefits page object
      def income_benefits_page
        Calculator::Test::IncomeBenefitsPage.new
      end

      # @return [Calculator::Test::TotalIncomePage] The total income page object
      def total_income_page
        Calculator::Test::TotalIncomePage.new
      end

      # @return [Calculator::Test::NotEligiblePage] The not eligible page object
      def not_eligible_page
        Calculator::Test::NotEligiblePage.new
      end

      # @return [Calculator::Test::FullRemissionPage] The full remission page object
      def full_remission_page
        Calculator::Test::FullRemissionPage.new
      end

      # @return [Calculator::Test::PartialRemissionPage] The partial remission page object
      def partial_remission_page
        Calculator::Test::PartialRemissionPage.new
      end

      # @return [Calculator::Test::BasePage] The base page object which applies to any page
      def any_calculator_page
        ::Calculator::Test::BasePage.new
      end
    end
  end
end
