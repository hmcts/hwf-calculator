module Calculator
  module Test
    # A page object for the calculator start page
    # This expects the page to be split into two sections
    # 1. The introduction
    # 2. The requirements from the users perspective
    class StartPage < BasePage
      set_url t('hwf_urls.start_page')
      element :heading, :exact_heading_text, t('hwf_pages.home.heading')
      element :introduction, '[data-behavior=introduction]'
      element :requirements, '[data-behavior=requirements]'
      element :disclaimer, '[data-behavior=disclaimer]'
      element :available_in_welsh, '[data-behavior=welsh_link]'
      element :switch_language_link, '[data-behavior=welsh_link] a'
      element :welsh_link, :link_or_button, t('hwf_pages.home.welsh_link.link_text', locale: :en)
      element :english_link, :link_or_button, t('hwf_pages.home.welsh_link.link_text', locale: :cy)
      element :start_button, :link_or_button, t('hwf_pages.home.buttons.start')

      # Begin a calculator session
      def start_session
        start_button.click
      end

      # Validates that the introduction text is correct for the english language
      # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
      # @return [Boolean] Should be true
      def validate_introduction
        introduction.assert_text messaging.t('hwf_pages.home.introduction_text'), exact: false
        true
      end

      # Validates that the requirements text is correct for the english language
      # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
      # @return [Boolean] Should be true
      def validate_requirements
        requirements.assert_text messaging.t('hwf_pages.home.requirements_text'), exact: false
        true
      end

      # Validates that the disclaimer text is correct for the english language
      # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
      # @return [Boolean] Should be true
      def validate_disclaimer
        disclaimer.assert_text messaging.t('hwf_pages.home.disclaimer_text'), exact: false
        true
      end

      # Validates that the welsh link is correct for the english language
      # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
      # @return [Boolean] Should be true
      def validate_welsh_link
        available_in_welsh.assert_text messaging.t('hwf_pages.home.welsh_link.full_text')
        switch_language_link.assert_text messaging.t('hwf_pages.home.welsh_link.link_text')
        true
      end

      # Switches the application to welsh
      # @raise [Capybara::ElementNotFound] If the welsh link was not found
      def switch_to_welsh
        welsh_link.click
        wait_for_english_link
      end

      # Switches the application to english
      # @raise [Capybara::ElementNotFound] If the english link was not found
      def switch_to_english
        english_link.click
        wait_for_welsh_link
      end
    end
  end
end
