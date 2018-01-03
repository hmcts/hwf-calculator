require_relative './question_checkbox_list'
module Calculator
  module Test
    class BenefitsCheckboxListSection < QuestionCheckboxListSection
      def dont_know_guidance
        option = option_labelled(messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know'))
        id_of_guidance = option.guidance_id
        find("##{id_of_guidance}")
      end

      def none_of_the_above_guidance
        option = option_labelled(messaging.t('hwf_pages.income_benefits.labels.benefits.none'))
        id_of_guidance = option.guidance_id
        find("##{id_of_guidance}")
      end
    end
  end
end
