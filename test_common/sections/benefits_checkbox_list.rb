module Calculator
  module Test
    class BenefitsCheckboxListSection < QuestionCheckboxListSection
      def dont_know_guidance
        option = option_labelled(messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know'))
        id_of_guidance = option['data-target']
        find("##{id_of_guidance}")
      end
    end
  end
end
