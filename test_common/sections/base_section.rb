require_relative '../messaging'
module Calculator
  module Test
    module BaseSection
      extend ActiveSupport::Concern

      include ::Calculator::Test::I18n

      def messaging
        @messaging ||= ::Calculator::Test::Messaging.instance
      end

      def i18n_scope
        self.class.i18n_scope
      end

      class_methods do
        def i18n_scope
          @i18n_scope
        end
      end
    end
  end
end
