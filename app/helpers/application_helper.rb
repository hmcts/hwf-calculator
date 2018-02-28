module ApplicationHelper
  # Renders a group of checkboxes following GDS guidelines with guidance text
  #
  # @param [ActionView::Helpers::FormBuilder] form
  # @param [Symbol] method The active model attribute to generate the multiple choices for
  # @param [Array<Array>] choices An array of arrays where the inner array contains the 'key', the
  #   'display text' and 'guidance id' (nil for none)
  #   guidance id will mean more to you if you are familiar with GDS multiple choices with guidance
  #
  # @return [String] The HTML to render
  def gds_multiple_choices_with_guidance(form:, method:, choices:)
    form.collection_check_boxes method, choices, :first, :second do |b|
      gds_checkbox_with_guidance(b)
    end
  end

  # Renders error messages for an attribute from a model or form object
  # based on active model, but renders them
  # GDS style (span with a class of 'error-message')
  # @param [ActiveModel::Model] model The model or form object to get the errors from
  # @param [Symbol] method The attribute that you want the error messages for
  def gds_error_messages(model:, method:)
    errors = model.errors
    return '' unless errors.include?(method)
    errors[method].each do |error|
      concat content_tag('span', error, class: 'error-message')
    end
    nil
  end

  def calculation_inputs_by_form(calculation)
    calculation.inputs.to_hash.inject({}) do |acc, (key, value)|
      form_type = CalculationFormService.for_field(key).type
      acc[form_type] ||= {}
      acc[form_type][key] = value
      acc
    end
  end

  def language_switcher_url
    link_to(t('language_switcher.link_text'), locale: locale_param_for(t('language_switcher.switch')))
  end

  def locale_param_for(t)
    t == 'en' ? nil : t
  end

  private

  def gds_checkbox_with_guidance(builder)
    guidance = builder.object.last
    guidance_id = "guidance_prefix_#{builder.object.first}"
    data_attrs = { target: guidance.present? ? guidance_id : nil }
    content = builder.check_box + builder.label
    if guidance.present?
      content << content_tag('div', guidance, class: 'panel panel-border-narrow js-hidden', id: guidance_id,
                                              data: { behavior: 'multiple_choice_guidance' })
    end
    content_tag('div', class: 'multiple-choice', data: data_attrs) { content }
  end
end
