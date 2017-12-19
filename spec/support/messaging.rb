module Calculator
  module Test
    module MessagingHelper
      def messaging
        @messaging ||= ::Calculator::Test::Messaging.new
      end
    end
  end
end

RSpec.configure do |c|
  c.include ::Calculator::Test::MessagingHelper
end