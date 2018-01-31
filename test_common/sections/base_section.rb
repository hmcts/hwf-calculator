module Calculator
  module Test
    class BaseSection < SitePrism::Section
      def messaging
        @messaging ||= ::Calculator::Test::Messaging.instance
      end
    end
  end
end
