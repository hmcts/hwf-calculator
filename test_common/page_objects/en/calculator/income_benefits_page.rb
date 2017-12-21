module Calculator
  module Test
    module En
      # A page object providing an interface to the 'Income Benefits Page'
      class IncomeBenefitsPage < BasePage
        section :benefits, ::Calculator::Test::BenefitsCheckboxListSection, :calculator_question, 'Select all income benefits you are currently receiving'
        element :next_button, :button, 'Next step'

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
      end
    end
  end
end
