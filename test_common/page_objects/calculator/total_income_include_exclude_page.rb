module Calculator
  module Test
    class TotalIncomeIncludeExcludePage < BasePopupPage
      set_url t('hwf_urls.total_income_include_exclude')
      element :include_list, :help_section_labelled, 'hwf_pages.help.total_income.include_exclude.include_list.label'
      element :exclude_list, :help_section_labelled, 'hwf_pages.help.total_income.include_exclude.exclude_list.label'
      element :back_element, :link, t('hwf_pages.help.total_income.include_exclude.back')



      def back
        back_element.click
      end

      def has_include_list?
        strings = Array(messaging.t("hwf_pages.help.total_income.include_exclude.include_list.text"))
        include_list.assert_text(strings.join("\n"), exact: false)
      end

      def has_exclude_list?
        strings = Array(messaging.t("hwf_pages.help.total_income.include_exclude.exclude_list.text"))
        exclude_list.assert_text(strings.join("\n"), exact: false)
      end
    end
  end
end