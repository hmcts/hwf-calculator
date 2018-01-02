module Calculator
  module Test
    module En
      class NumberOfChildrenPage < BasePage
        # @TODO Number of children has not been defined yet - it is part of another feature
        # So, the URL below is deliberately WRONG, but the correct URL is in a comment below it
        # @TODO Review and correct this as part of RST-670.  I have added a comment in 670 to ensure it is addressed
        # although it should be naturally as the tests should start failing once the next page is added
        set_url '/calculation/full_remission_available'
        #set_url '/calculation/number_of_children'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end
