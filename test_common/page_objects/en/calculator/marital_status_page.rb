module Calculator
  module Test
    module En
      class MaritalStatusPage < BasePage
        set_url '/calculation/marital_status'
        element :heading, :exact_heading_text, t('hwf_pages.marital_status.heading')
        element :next_button, :button, t('hwf_pages.marital_status.buttons.next')

        section :marital_status, :calculator_question, t('hwf_pages.marital_status.questions.marital_status.label') do
          @i18n_scope = 'hwf_pages.marital_status.questions.marital_status'
          include ::Calculator::Test::MaritalStatusQuestionSection
        end

        # Progress to the next page
        def next
          next_button.click
        end

        delegate :has_no_guidance_text?,
          :toggle_guidance,
          :validate_guidance,
          :wait_for_guidance_text,
          to: :marital_status
      end
    end
  end
end
