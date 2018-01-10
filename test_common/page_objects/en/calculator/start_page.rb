module Calculator
  module Test
    module En
      class StartPage < BasePage
        set_url '/'
        element :start_button, :link_or_button, 'Start now'

        # Begin a calculator session
        def start_session
          start_button.click
        end
      end
    end
  end
end
