module Calculator
  module Test
    module En
      class CourtFeePage < BasePage
        set_url '/calculation/fee'
        element :heading, :exact_heading_text, t('hwf_pages.fee.heading')
        section :fee, :calculator_question, t('hwf_pages.fee.questions.fee.label') do
          @i18n_scope = 'hwf_pages.fee.questions.fee'
          include ::Calculator::Test::CourtFeeQuestionSection
        end
        element :next_button, :button, t('hwf_pages.fee.buttons.next')

        # Progress to the next page
        def next
          next_button.click
        end

        delegate :has_no_guidance_text?,
          :toggle_guidance,
          :validate_guidance,
          :wait_for_guidance_text,
          to: :fee
      end
    end
  end
end
