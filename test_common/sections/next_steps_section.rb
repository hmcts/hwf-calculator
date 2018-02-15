module Calculator
  module Test
    module NextStepsSection
      extend ActiveSupport::Concern
      include BaseSection

      included do
        element :start_again_link, :link_or_button, t('hwf_components.next_steps.start_again')
      end
    end
  end
end
