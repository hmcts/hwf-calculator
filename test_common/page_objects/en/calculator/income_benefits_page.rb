module Calculator
  module Test
    module En
      # A page object providing an interface to the 'Income Benefits Page'
      class IncomeBenefitsPage < BasePage
        set_url '/calculation/benefits_received'
        element :heading, :exact_heading_text, t('hwf_pages.income_benefits.heading')
        section :benefits, :calculator_question, t('hwf_pages.income_benefits.questions.benefits.label') do
          @i18n_scope = 'hwf_pages.income_benefits.questions.benefits'
          include ::Calculator::Test::BenefitsCheckboxListSection
        end
        element :next_button, :button, t('hwf_pages.income_benefits.buttons.next')

        def benefit_options
          [:jobseekers_allowance, :employment_support_allowance, :income_support, :universal_credit, :pension_credit, :scottish_legal_aid].each do |benefit|
            benefits.option_labelled benefit
          end
        end

        def choose_jobseekers_allowance
          choose :jobseekers_allowance
        end

        def choose_income_support
          choose :income_support
        end

        def choose_universal_credit
          choose :universal_credit
        end

        # Clicks the next button
        def next
          next_button.click
        end

        # Chooses the 'None of the above' option in the list
        def choose_none
          benefits.set(:none)
        end

        # Chooses the 'Dont know' option in the list
        def choose_dont_know
          choose :dont_know
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

        def dont_know_guidance
          benefits.dont_know_guidance
        end

        def none_of_the_above_guidance
          benefits.none_of_the_above_guidance
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          benefits.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          benefits.validate_guidance
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          benefits.has_no_help_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          benefits.wait_for_help_text
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
      end
    end
  end
end
