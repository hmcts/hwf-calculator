require_relative '../../sections'
require_relative '../../messaging'
module Calculator
  module Test
    # @abstract
    # @private
    class BasePopupPage < ::SitePrism::Page
      include ::Calculator::Test::I18n

      def messaging
        @messaging ||= ::Calculator::Test::Messaging.instance
      end
    end
  end
end
