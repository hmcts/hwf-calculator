module Calculator
  module Test
    class ExceptionalHardshipPage < BasePopupPage
      set_url t('hwf_urls.exceptional_hardship')
      element :page_header, :exact_heading_text, t('hwf_pages.help.exceptional_hardship.page_header')
      element :main_section, :help_section_labelled, 'hwf_pages.help.exceptional_hardship.main_section.label'
      element :back_element, :link, t('hwf_pages.help.exceptional_hardship.back')



      def back
        back_element.click
      end

      def has_main_section?
        strings = Array(messaging.t("hwf_pages.help.exceptional_hardship.main_section.text"))
        main_section.assert_text(strings.join("\n"), exact: false)
      end
    end
  end
end