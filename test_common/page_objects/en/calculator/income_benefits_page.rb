module Calculator
  module Test
    module En
      # A page object providing an interface to the 'Income Benefits Page'
      class IncomeBenefitsPage < BasePage
        section :benefits, ::Calculator::Test::BenefitsCheckboxListSection, :calculator_question, 'Select all income benefits you are currently receiving'
        element :positive_eligibility_header, '.positive', text: 'You are able to get help with fees'
        element :johns_eligibility_message, '.positive', text: 'With a fee of £600 and savings of £2,990, you should be able to get help with your fees, as long as you receive certain benefits or are on a low income'
        element :jobseekers_allowance, '.multiple-choice', text: 'Income-based Jobseeker’s Allowance (JSA)'
        element :employment_support_allowance, '.multiple-choice', text: 'Income-related Employment and Support Allowance (ESA)'
        element :income_support, '.multiple-choice', text: 'Income Support'
        element :universal_credit, '.multiple-choice', text: 'Universal Credit (and you’re earning less than £6,000 a year)'
        element :pension_credit, '.multiple-choice', text: 'Pension Credit (guarantee credit)'
        element :scottish_legal_aid, '.multiple-choice', text: 'Scottish Legal Aid (Civil Claims)'
        element :none_of_the_above, '.multiple-choice', text: 'None of the above'
        element :prefix_none, '#prefix_none', text: 'None of the above guidance'
        element :dont_know, '.multiple-choice', text: 'Don\'t know'
        element :prefix_dont_know, '#prefix_dont_know', text: 'Don\'t know guidance'
        element :next_button, :button, 'Next step'
        element :error_message, '.error-message', text: 'Please select from the list'
       

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
      end
    end
  end
end
