module Calculator
  module Test
    class NotEligiblePage < BasePage
      set_url t('hwf_urls.not_eligible')

      section :next_steps, :next_steps_labelled, t('hwf_components.next_steps.label') do
        include ::Calculator::Test::NextStepsSection
      end
      element :exceptional_hardship_link, :link, t('hwf_decision.common.exceptional_hardship')

      def start_again
        next_steps.start_again_link.click
      end

      def open_exceptional_hardship
        exceptional_hardship_link.click
      end

      # Verifies that the final negative remission message is present
      # @param [OpenStruct] user The user containing the fee and the monthly_gross_income
      #
      # @return [Boolean] true if all OK
      # @raise [Capybara::ElementNotFound] If the correct message was not found
      def valid_for_final_negative_message?(user)
        marital_status = user.marital_status.downcase
        expected_header = messaging.translate "hwf_decision.no_remission.#{marital_status}.heading"
        expected_detail = messaging.translate "hwf_decision.no_remission.#{marital_status}.negative.detail",
          fee: number_to_currency(user.fee, precision: 0, unit: '£'),
          total_income: number_to_currency(user.monthly_gross_income, precision: 0, unit: '£')

        !!(feedback_message_with_header(expected_header) &&
            feedback_message_with_detail(expected_detail))
      end

    end
  end
end
