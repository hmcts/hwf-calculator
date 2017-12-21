module Calculator
  module Test
    module En
      class NumberOfChildrenPage < BasePage
        set_url '/calculation/number_of_children'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end
