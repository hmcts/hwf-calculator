module Calculator
  module Test
    module Pages
      def start_page
        Calculator::Test::En::StartPage.new
      end

      def marital_status_page
        Calculator::Test::En::MaritalStatusPage.new
      end

      def court_fee_page
        Calculator::Test::En::CourtFeePage.new
      end

      def date_of_birth_page
        Calculator::Test::En::DateOfBirthPage.new
      end

      def disposable_capital_page
        Calculator::Test::En::DisposableCapitalPage.new
      end

      # @return [Calculator::Test::En::NumberOfChildrenPage] The number of children page object
      def number_of_children_page
        Calculator::Test::En::NumberOfChildrenPage.new
      end

      # @return [Calculator::Test::En::IncomeBenefitsPage] The benefits page object
      def income_benefits_page
        Calculator::Test::En::IncomeBenefitsPage.new
      end

      # @return [Calculator::Test::En::TotalIncomePage] The total income page object
      def total_income_page
        Calculator::Test::En::TotalIncomePage.new
      end

      # @return [Calculator::Test::En::NotEligiblePage] The not eligible page object
      def not_eligible_page
        Calculator::Test::En::NotEligiblePage.new
      end

      # @return [Calculator::Test::En::FullRemissionPage] The full remission page object
      def full_remission_page
        Calculator::Test::En::FullRemissionPage.new
      end

      # @return [Calculator::Test::En::PartialRemissionPage] The partial remission page object
      def partial_remission_page
        Calculator::Test::En::PartialRemissionPage.new
      end

      # @return [Calculator::Test::En::BasePage] The base page object which applies to any page
      def any_calculator_page
        ::Calculator::Test::En::BasePage.new
      end
    end
  end
end
