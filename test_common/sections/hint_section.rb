module Calculator
  module Test
    module HintSection
      extend ActiveSupport::Concern

      included do
        element :hint, '.form-hint', text: t("#{i18n_scope}.hint")
      end
    end
  end
end
