module Calculator
  module Test
    class BaseSection < SitePrism::Section
      def messaging
        @messaging ||= ::Calculator::Test::Messaging.new
      end
    end
  end
end
