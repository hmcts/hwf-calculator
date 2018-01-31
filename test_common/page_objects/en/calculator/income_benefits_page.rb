module Calculator
  module Test
    module En
      # A page object providing an interface to the 'Income Benefits Page'
      class IncomeBenefitsPage < BasePage
        set_url '/calculation/benefits_received'
        element :heading, :exact_heading_text, 'Find out if you could get help with fees'
        section :benefits, ::Calculator::Test::BenefitsCheckboxListSection, :calculator_question, 'Select all income benefits you are currently receiving'
        element :next_button, :button, 'Next step'

        def benefit_options
          [:jobseekers_allowance, :employment_support_allowance, :income_support, :universal_credit, :pension_credit, :scottish_legal_aid].each do |benefit|
            benefits.option_labelled messaging.t("hwf_pages.income_benefits.labels.benefits.#{benefit}")
          end
        end

        def choose_jobseekers_allowance
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.jobseekers_allowance')
          benefits.set([label_text])
        end

        def choose_income_support
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.income_support')
          benefits.set([label_text])
        end

        def choose_universal_credit
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.universal_credit')
          benefits.set([label_text])
        end

        # Clicks the next button
        def next
          next_button.click
        end

        # Chooses the 'None of the above' option in the list
        def choose_none
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.none')
          benefits.set([label_text])
        end

        # Chooses the 'Dont know' option in the list
        def choose_dont_know
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know')
          benefits.set([label_text])
        end

        # The don't know checkbox
        #
        # @return [Capybara::Node::Element]
        def dont_know_option
          benefits.option_labelled messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know')
        end

        # The none of the above checkbox
        #		
        # @return [Capybara::Node::Element]
        def none_of_the_above_option
          benefits.option_labelled messaging.t('hwf_pages.income_benefits.labels.benefits.none')
        end

        def dont_know_guidance
          benefits.dont_know_guidance
        end

        def none_of_the_above_guidance
          benefits.none_of_the_above_guidance
        end

        def error_nothing_selected
          benefits.error_with_text(messaging.t('hwf_pages.income_benefits.errors.nothing_selected'))
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          benefits.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          benefits.validate_guidance(messaging.t('hwf_pages.income_benefits.guidance.benefits.text'))
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

        # Indicates if the page has only the 'None of the above' option selected - waits for it if not then returns
        # false if it never arrives
        # @return [Boolean] Indicates if the page has only the 'None of the above' option selected
        def has_only_none_selected?
          benefits.has_value?([messaging.t('hwf_pages.income_benefits.labels.benefits.none')])
        end

        # Indicates if the page has only the 'Dont know' option selected - waits for it if not then returns
        # false if it never arrives
        # @return [Boolean] Indicates if the page has only the 'Dont know' option selected
        def has_only_dont_know_selected?
          benefits.has_value?([messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know')])
        end

        # Indicates if the page has only the values specified options selected - waits for them if not then returns
        # false if it never arrives
        # @return [Boolean] Indicates if the page has only the specified options selected
        def has_selected?(values)
          benefits.has_value?(values)
        end
      end
    end
  end
end
