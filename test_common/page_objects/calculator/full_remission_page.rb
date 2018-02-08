module Calculator
  module Test
    class FullRemissionPage < BasePage
      include ActiveSupport::NumberHelper
      set_url t('hwf_urls.full_remission')

      def valid_for_final_positive_message?(user)
        marital_status = user.marital_status.downcase
        expected_header = messaging.translate "hwf_decision.final.#{marital_status}.positive.heading"
        expected_detail = messaging.translate "hwf_decision.final.#{marital_status}.positive.detail",
          fee: number_to_currency(user.fee, precision: 0, unit: '£'),
          total_income: number_to_currency(user.monthly_gross_income, precision: 0, unit: '£')
        feedback_message_with_header(expected_header) &&
          feedback_message_with_detail(expected_detail)
      end
    end
  end
end
