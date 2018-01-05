module Calculator
  module Test
    module En
      class FullRemissionPage < BasePage
        set_url '/calculation/full_remission_available'

        element :positive, '.positive'
      end
    end
  end
end
