module Calculator
  module Test
    class PartialRemissionPage < BasePage
      include ActiveSupport::NumberHelper
      set_url t('hwf_urls.partial_remission')

      section :next_steps, :next_steps_labelled, t('hwf_components.next_steps.label') do
        include ::Calculator::Test::NextStepsSection
      end

      def start_again
        next_steps.start_again_link.click
      end

      # Verifies that the final partial remission message is present
      # @param [OpenStruct] user The user containing the fee and the monthly_gross_income
      # @param [Fixnum] citizen_pays The expected amount the citizen must pay
      #
      # @return [Boolean] true if all OK
      # @raise [Capybara::ElementNotFound] If the correct message was not found
      def valid_for_final_partial_message?(user, citizen_pays:)
        !!(feedback_message_with_header(expected_header_for user) && feedback_message_with_detail(expected_detail_for user, citizen_pays))
      end

      private

      def expected_header_for(user)
        messaging.translate "hwf_decision.partial.#{user.marital_status}.positive.heading"
      end

      def expected_detail_for(user, citizen_pays)
        marital_status = user.marital_status.downcase
        messaging.translate "hwf_decision.partial.#{marital_status}.positive.detail",
          fee: number_to_currency(user.fee, precision: 0, unit: '£'),
          total_income: number_to_currency(user.monthly_gross_income, precision: 0, unit: '£'),
          remission: number_to_currency(user.fee - citizen_pays, precision: 0, unit: '£'),
          contribution: number_to_currency(citizen_pays, precision: 0, unit: '£')
      end
    end
  end
end
