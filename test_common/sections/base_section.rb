module Calculator
  module Test
    module BaseSection
      extend ActiveSupport::Concern
      def messaging
        @messaging ||= ::Calculator::Test::Messaging.instance
      end
    end
  end
end
