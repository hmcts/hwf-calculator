module Calculator
  module Test
    module En
      # A page object for the calculator start page
      # This expects the page to be split into two sections
      # 1. The introduction
      # 2. The requirements from the users perspective
      class StartPage < BasePage
        set_url '/'
        element :heading, :exact_heading_text, 'Find out if you could get help with fees'
        element :introduction, '[data-behavior=introduction]'
        element :requirements, '[data-behavior=requirements]'
        element :disclaimer, '[data-behavior=disclaimer]'
        element :available_in_welsh, '[data-behavior=welsh_link]'
        element :welsh_link, '[data-behavior=welsh_link] a'
        element :start_button, :link_or_button, 'Start now'

        # Begin a calculator session
        def start_session
          start_button.click
        end

        # Validates that the introduction text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        # @return [Boolean] Should be true
        def validate_introduction
          introduction.assert_text messaging.t('hwf_pages.home.introduction_text')
          true
        end

        # Validates that the requirements text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        # @return [Boolean] Should be true
        def validate_requirements
          requirements.assert_text messaging.t('hwf_pages.home.requirements_text')
          true
        end

        # Validates that the disclaimer text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        # @return [Boolean] Should be true
        def validate_disclaimer
          disclaimer.assert_text messaging.t('hwf_pages.home.disclaimer_text')
          true
        end

        # Validates that the welsh link is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        # @return [Boolean] Should be true
        def validate_welsh_link
          available_in_welsh.assert_text messaging.t('hwf_pages.home.welsh_link.full_text')
          welsh_link.assert_text messaging.t('hwf_pages.home.welsh_link.link_text')
          true
        end
      end
    end
  end
end
