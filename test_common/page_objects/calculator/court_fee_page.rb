module Calculator
  module Test
    # A page object representing the court fee page
    #
    # This page has 1 simple question called 'fee' which is a standard calculator
    # question.
    #
    # @!method fee
    #   The fee question
    #   @return [SitePrism::Section<CourtFeeQuestionSection>]
    #
    # @example Filling in the fee value and going to next page
    #   my_page.fee.set(1500)
    #   my_page.next
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

      # @!method has_no_guidance_text?
      #   @see CourtFeeQuestionSection#has_no_guidance_text?
      # @!method toggle_guidance
      #   @see CourtFeeQuestionSection#toggle_guidance
      # @!method validate_guidance
      #   @see CourtFeeQuestionSection#validate_guidance
      # @!method wait_for_guidance_text
      #   @see CourtFeeQuestionSection#wait_for_guidance_text
      delegate :has_no_guidance_text?,
        :toggle_guidance,
        :validate_guidance,
        :wait_for_guidance_text,
        to: :fee
    end
  end
end
