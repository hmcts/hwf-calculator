module Calculator
  module Test
    # A page object providing an interface to the 'Income Benefits Page'
    class IncomeBenefitsPage < BasePage
      set_url '/calculation/benefits_received'
      element :heading, :exact_heading_text, t('hwf_pages.income_benefits.heading')
      element :next_button, :button, t('hwf_pages.income_benefits.buttons.next')

      section :benefits, :calculator_question, t('hwf_pages.income_benefits.questions.benefits.label') do
        @i18n_scope = 'hwf_pages.income_benefits.questions.benefits'
        include ::Calculator::Test::BenefitsCheckboxListSection
      end

      def benefit_options
        [:jobseekers_allowance, :employment_support_allowance, :income_support, :universal_credit, :pension_credit, :scottish_legal_aid].each do |benefit|
          benefits.option_labelled benefit
        end
      end

      # Clicks the next button
      def next
        next_button.click
      end

      # Chooses a single or multiple items by label.  The labels are specified by I18n key so the
      # test suite can be multi lingual
      # @param [Symbol] keys Single or multiple keys into "hwf_pages.income_benefits.labels.benefits"
      #   in the messaging/en.yml file.  Can be one of :dont_know, :none, :jobseekers_allowance,
      #   :employment_support_allowance, :income_support, :universal_credit, :pension_credit,
      #   :scottish_legal_aid
      def choose(*keys)
        benefits.set(*keys)
      end

      # Indicates if the page has only the values specified options selected - waits for them if not then returns
      # false if it never arrives
      # @return [Boolean] Indicates if the page has only the specified options selected
      # @param [Array[String|Symbol]] values An array of strings or symbols.  If symbols, then the values are
      #   translated using hwf_pages.income_benefits.labels.benefits.#{key} in the messaging/en.yml file.
      #   Can also be multiple values not in an array.
      def has_selected?(*values)
        benefits.has_value?(*values)
      end

      delegate :has_no_guidance_text?,
        :toggle_guidance,
        :validate_guidance,
        :wait_for_guidance_text,
        :dont_know_guidance,
        :none_of_the_above_guidance,
        to: :benefits
    end
  end
end
