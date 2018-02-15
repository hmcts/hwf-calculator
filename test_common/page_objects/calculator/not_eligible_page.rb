module Calculator
  module Test
    class NotEligiblePage < BasePage
      set_url t('hwf_urls.not_eligible')

      section :next_steps, :next_steps_labelled, t('hwf_components.next_steps.label') do
        include ::Calculator::Test::NextStepsSection
      end

      def start_again
        next_steps.start_again_link.click
      end
    end
  end
end
