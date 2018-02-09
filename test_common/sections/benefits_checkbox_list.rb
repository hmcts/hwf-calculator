require_relative './question_checkbox_list'
require_relative 'question_guidance'
require_relative 'guidance_section'
module Calculator
  module Test
    # A page object 'section' representing a benefits checkbox list.
    # This section interfaces to the benefits checkbox list using its #set
    # and #has_value? methods (and more).  Allowing the test suite to set
    # multiple options at once and to easily verify that certain options are
    # selected.
    #
    # Translation is done inside this section, but it expects the @i18n_scope class variable
    # to be defined.  The @i18n_scope has to be defined in a standard SitePrism section defined
    # as a block and then this module included.
    #
    # @example Using this section in a site prism page
    #   class MyPage < SitePrism::Page
    #     section :benefits, '.some-selector' do
    #       @i18n_scope = 'my_page.benefits'
    #       include ::Calculator::Test::BenefitsCheckboxListSection
    #     end
    #   end
    #
    # Using the 'Using this section' example means that all of the messaging required starts from the
    # i18n scope of 'my_page.benefits'.
    #
    # @example The translation file should have this under the 'i18n scope' defined
    #   errors:
    #     nothing_selected: 'Nothing selected error message'
    #   options:
    #     dont_know:
    #     label: 'Dont Know Label'
    #     guidance: |
    #       Guidance line 1
    #       Guidance line 2
    #   none:
    #     label: 'None Label'
    #     guidance: |
    #       Guidance line 1
    #       Guidance line 2
    #
    #   and then any further options listed in the same manner - the above 2 are special and
    #   are always present.
    #
    # @example Setting multiple values from the test suite
    #   my_page.benefits.set(:job_seekers_allowance, :pension_credit)
    #
    #   which would require these options to be defined in the translation file(s)
    #
    # @example Fetching a single option
    #   option = my_page.benefits.option_labelled_jobseekers_allowance
    #   option.label <# "Jobseekers Allowance"
    #
    #   These methods are generated automatically to match the options set
    #   in <i18n_root>.options
    #
    #   and they return a @see ::Calculator::Test::GdsMultipleChoiceOptionSection
    #
    # @!method error_nothing_selected
    #   Returns the 'nothing selected' error message and raises if its not present.
    #   As with all site prism elements, you can use things like has_error_nothing_selected?
    #   to test if this is present or not.
    #   @return [Capybara::Node::Element] The node containing the correct error text
    #   @raise [Capybara::ElementNotFound] if the correct error text was not present within this section
    module BenefitsCheckboxListSection
      extend ActiveSupport::Concern

      include QuestionCheckboxListSection
      include GuidanceSection

      included do
        element :error_nothing_selected, :exact_error_text, t("#{i18n_scope}.errors.nothing_selected")
        t("#{i18n_scope}.options").each_pair do |key, value|
          section :"option_labelled_#{key}", :gds_multiple_choice_option, value[:label] do
            include GdsMultipleChoiceOptionSection
          end
        end
      end

      # Finds the "Don't Know" option's guidance text node or raises if not found
      # @return [Capybara::Node::element] The dont know guidance capybara node
      # @raise [Capybara::ElementNotFound] if the correct guidance was not present within the node section
      def dont_know_guidance
        option = option_labelled_dont_know
        option.guidance_with_text(messaging.t("#{i18n_scope}.options.dont_know.guidance"))
      end

      # Finds the "None of the above" option's guidance text node or raises if not found
      # @return [Capybara::Node::element] The none of the above guidance capybara node
      # @raise [Capybara::ElementNotFound] if the correct guidance was not present within the node section
      def none_of_the_above_guidance
        option = option_labelled_none
        option.guidance_with_text(messaging.t("#{i18n_scope}.options.none.guidance"))
      end

      def option_labelled(option)
        send(:"option_labelled_#{option}")
      end

      # Selects single or multiple items by label.  The labels are specified by I18n key so the
      # test suite can be multi lingual
      # @param [Symbol] keys Single or multiple keys into "<i18n_scope>.options"
      #   in the messaging/en.yml file.  Can be one of :dont_know, :none, :jobseekers_allowance,
      #   :employment_support_allowance, :income_support, :universal_credit, :pension_credit,
      #   :scottish_legal_aid
      def set(*keys)
        labels = keys.flatten.map do |key|
          if key.is_a?(Symbol)
            messaging.t("#{i18n_scope}.options.#{key}.label")
          else
            key
          end
        end
        super(labels)
      end

      # Indicates if the page has only the values specified options selected - waits for them if not then returns
      # false if it never arrives
      # @return [Boolean] Indicates if the page has only the specified options selected
      # @param [Array[String|Symbol]] values An array of strings or symbols.  If symbols, then the values are
      #   translated using <i18n_scope>.options.#{key}.label in the messaging/en.yml file.
      #   Can also be multiple values not in an array.
      def has_value?(*values)
        v = values.flatten.map do |value|
          if value.is_a?(Symbol)
            messaging.t("#{i18n_scope}.options.#{value}.label")
          else
            value
          end
        end
        super(v)
      end
    end
  end
end
