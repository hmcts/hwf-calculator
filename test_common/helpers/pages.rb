module Calculator
  module Test
    module Pages
      def start_page
        @start_page ||= Calculator::Test::En::StartPage.new
      end

      def marital_status_page
        @marital_status_page ||= Calculator::Test::En::MaritalStatusPage.new
      end

      def court_fee_page
        @court_fee_page ||= Calculator::Test::En::CourtFeePage.new
      end

      def date_of_birth_page
        @date_of_birth_page ||= Calculator::Test::En::DateOfBirthPage.new
      end

      def disposable_capital_page
        @disposable_capital_page ||= Calculator::Test::En::DisposableCapitalPage.new
      end

      # @return [Calculator::Test::En::IncomeBenefitsPage] The benefits page object
      def income_benefits_page
        @income_benefits_page ||= Calculator::Test::En::IncomeBenefitsPage.new
      end

      # @return [Calculator::Test::En::FullRemissionPage] The full remission page object
      def full_remission_page
        @full_remission_page ||= Calculator::Test::En::FullRemissionPage.new
      end
    end

  end
end
