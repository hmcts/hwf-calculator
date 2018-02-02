module Calculator
  module Test
    # A sub section for any question section that represents a question that has guidance text to
    # assist the user.  The guidance text can be toggled using this section, the text
    # can be validated and the test suite can validate if the guidance text is hidden etc..
    #
    # Translation is done inside this section, but it expects the @i18n_scope class variable
    # to be defined.  As this is generally expected to be used inside another section (the
    # question section) then it will pick up @i18n_scope from there
    #
    # @example Using this section in a question section
    #     module MySection
    #       extend ActiveSupport::Concern
    #
    #       include ::Calculator::Test::GuidanceSection
    #     end
    #
    #     class MyPage < SitePrism::Page
    #       section :benefits, '.some-selector' do
    #         @i18n_scope = 'my_page.benefits'
    #         include MySection
    #       end
    #     end
    #
    # @example Toggling guidance
    #   my_page.benefits.toggle_guidance
    #   my_page.benefits.wait_for_guidance_text
    #
    #   Which will toggle the guidance and wait for it to be visible
    #
    # Using the 'Using this section in a question section' example means that all of the messaging required starts from the
    # i18n scope of 'my_page.benefits'.
    #
    # Once included, the module will add a 'guidance_section' and the documented methods below
    #
    # @!method guidance_section
    #   Returns the correctly labelled guidance section and raises if its not present.
    #   As with all site prism elements, you can use things like has_guidance_section?
    #   to test if this is present or not.
    #   @return [SitePrism::Section<QuestionGuidanceSection>] The section containing the guidance.  A normal site prism section which includes ::Calculator::Test::QuestionGuidanceSection
    #   @raise [Capybara::ElementNotFound] if the correct error text was not present within this section
    #
    module GuidanceSection
      extend ActiveSupport::Concern
      included do
        section :guidance_section, :guidance_section_labelled, t("#{i18n_scope}.guidance.label") do
          include QuestionGuidanceSection
        end

        delegate :wait_for_guidance_text, to: :guidance_section
        delegate :wait_for_no_guidance_text, to: :guidance_section
      end

      # Validates that the guidance text is as expected
      # @raise [Capybara::ExpectationNotMet] if the assertion hasn't succeeded during wait time
      def validate_guidance
        strings = Array(messaging.t("#{i18n_scope}.guidance.text"))
        guidance_section.assert_text(strings.join("\n"))
      end

      # Toggles the guidance on/off
      def toggle_guidance
        guidance_section.toggle
      end

      # Validates that the guidance text is hidden
      # @return [Boolean] True if the guidance text is hidden
      def has_no_guidance_text?
        guidance_section.guidance_text_collapsed?
      end
    end
  end
end
