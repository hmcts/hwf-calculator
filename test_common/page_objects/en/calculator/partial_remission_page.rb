module Calculator
  module Test
    module En
      class PartialRemissionPage < BasePage
        include ActiveSupport::NumberHelper
        set_url '/calculation_result/partial_remission'

        # Verifies that the final partial remission message is present
        # @param [OpenStruct] user The user containing the fee and the monthly_gross_income
        # @param [Fixnum] remission The expected remission as passed from the test suite
        #
        # @return [Boolean] true if all OK
        # @raise [Capybara::ElementNotFound] If the correct message was not found
        def valid_for_final_partial_message?(user, remission:)
          marital_status = user.marital_status.downcase
          expected_header = messaging.translate "hwf_decision.partial.#{marital_status}.positive.heading"
          expected_detail = messaging.translate "hwf_decision.partial.#{marital_status}.positive.detail",
            fee: number_to_currency(user.fee, precision: 0, unit: '£'),
            total_income: number_to_currency(user.monthly_gross_income, precision: 0, unit: '£'),
            remission: number_to_currency(remission, precision: 0, unit: '£'),
            contribution: number_to_currency(user.fee - remission, precision: 0, unit: '£')

          !!(feedback_message_with_header(expected_header) &&
              feedback_message_with_detail(expected_detail))
        end
      end
    end
  end
end
