module Calculator
  module Test
    module Setup
      attr_accessor :user
      def answer_questions_up_to_benefits
        start_calculator_session
        answer_marital_status_question
        answer_court_fee_question
        answer_date_of_birth_question
        answer_disposable_capital_question
      end

      def answer_disposable_capital_question
        disposable_capital_page.disposable_capital.set(user.disposable_capital)
        disposable_capital_page.next
      end

      def answer_date_of_birth_question
        date_of_birth_page.date_of_birth.set(user.date_of_birth)
        date_of_birth_page.next
      end

      def start_calculator_session
        start_page.load_page
        start_page.start_session
      end

      def answer_marital_status_question
        marital_status_page.marital_status.set(user.marital_status)
        marital_status_page.next
      end

      def answer_court_fee_question
        court_fee_page.fee.set(user.fee)
        court_fee_page.next
      end

      def given_i_am(user_name)
        self.user = personas.fetch(user_name)
        user.date_of_birth = (user.age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')
      end
    end
  end
end
