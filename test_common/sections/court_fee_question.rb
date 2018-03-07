require_relative 'question_numeric'
require_relative 'question_guidance'
require_relative 'guidance_section'
require_relative 'hint_section'
module Calculator
  module Test
    # A section representing the court fee question
    # This section interfaces to the court fee question using its #set
    # and #has_value? methods (and more).  Allowing the test suite to set
    # the value and to validate if the value is as expected.
    #
    # Translation is done inside this section, but it expects the @i18n_scope class variable
    # to be defined.  The @i18n_scope has to be defined in a standard SitePrism section defined
    # as a block and then this module included.
    #
    # @example Using this section in a site prism page
    #   class MyPage < SitePrism::Page
    #     section :court_fee, '.some-selector' do
    #       @i18n_scope = 'my_page.court_fee'
    #       include ::Calculator::Test::CourtFeeQuestionSection
    #     end
    #   end
    #
    # Using the 'Using this section in a site prism page' example means that all of the messaging required starts from the
    # i18n scope of 'my_page.court_fee'.
    # @example The translation file should have this under the 'i18n scope' defined
    #   errors:
    #     non_numeric: 'Expected non numeric error message'
    #   guidance:
    #     label: 'The expected guidance label that is clicked to show the text'
    #     text: 'The expected guidance text - can be multi line etc.. white space is ignored as are tags'
    #
    # @!method error_non_numeric
    #   Returns the 'not numeric' error message and raises if its not present.
    #   As with all site prism elements, you can use things like has_error_non_numeric?
    #   to test if this is present or not.
    #   @return [Capybara::Node::Element] The node containing the correct error text
    #   @raise [Capybara::ElementNotFound] if the correct error text was not present within this section
    module CourtFeeQuestionSection
      extend ActiveSupport::Concern
      include QuestionNumericSection
      include GuidanceSection

      included do
        element :error_non_numeric, :exact_error_text, t("#{i18n_scope}.errors.non_numeric")
        element :error_less_than_one, :exact_error_text, t("#{i18n_scope}.errors.less_than_one")
      end
    end
  end
end
