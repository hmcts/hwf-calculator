module Calculator
  module Test
    module Setup
      QUESTIONS = [
        :all,
        :marital_status, :court_fee, :date_of_birth, :disposable_capital,
        :benefits, :number_of_children, :total_income
      ].freeze

      attr_accessor :user

      def answer_up_to(question)
        start_calculator_session
        QUESTIONS[1..QUESTIONS.index(question) -1].each do |q|
          answer_question(q)
        end
      end

      def answer_question(question)
        send "answer_#{question}_question".to_sym
      end

      def answer_questions_up_to_benefits
        answer_questions_up_to_disposable_capital
        answer_disposable_capital_question
      end
      deprecate :answer_questions_up_to_benefits, 'answer_questions_up_to_benefits is deprecated, use answer_up_to(:benefits)'

      def answer_questions_up_to_disposable_capital
        answer_questions_up_to_date_of_birth
        answer_date_of_birth_question
      end
      deprecate :answer_questions_up_to_disposable_capital, 'answer_questions_up_to_disposable_capital is deprecated, use answer_up_to(:disposable_capital)'

      def answer_questions_up_to_date_of_birth
        answer_questions_up_to_court_fee
        answer_court_fee_question
      end
      deprecate :answer_questions_up_to_date_of_birth, 'answer_questions_up_to_date_of_birth is deprecated, use answer_up_to(:date_of_birth)'

      def answer_up_to_marital_status_question
        start_calculator_session
      end
      deprecate :answer_up_to_marital_status_question, 'answer_up_to_marital_status_question is deprecated, use answer_up_to(:marital_status)'

      def answer_questions_up_to_court_fee
        answer_up_to_marital_status_question
        answer_marital_status_question
      end
      deprecate :answer_questions_up_to_court_fee, 'answer_questions_up_to_court_fee is deprecated, use answer_up_to(:court_fee)'

      def answer_questions_up_to_total_income
        answer_questions_up_to_number_of_children
        answer_number_of_children_question
      end
      deprecate :answer_questions_up_to_total_income, 'answer_questions_up_to_total_income is deprecated, use answer_up_to(:total_income)'

      def answer_questions_up_to_number_of_children
        answer_questions_up_to_benefits
        answer_benefits_question
      end
      deprecate :answer_questions_up_to_number_of_children, 'answer_questions_up_to_number_of_children is deprecated, use answer_up_to(:number_of_children)'

      def answer_disposable_capital_question
        disposable_capital_page.disposable_capital.set(user.disposable_capital)
        disposable_capital_page.next
      end

      def answer_date_of_birth_question
        date_of_birth_page.date_of_birth.set(user.date_of_birth)
        if user.partner_date_of_birth.present?
          date_of_birth_page.partner_date_of_birth.set(user.date_of_birth)
        end
        date_of_birth_page.next
      end

      def answer_benefits_question
        income_benefits_page.benefits.set(user.income_benefits)
        income_benefits_page.next
      end

      def answer_number_of_children_question
        number_of_children_page.number_of_children.set(user.number_of_children)
        number_of_children_page.next
      end

      def answer_total_income_question
        total_income_page.total_income.set(user.monthly_gross_income)
        total_income_page.next
      end

      def answer_all_questions
        answer_up_to(:all)
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
        if user.partner_age.present?
          user.partner_date_of_birth = (user.partner_age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')
        end
        return if user.income_benefits.nil?
        user.income_benefits.map! do |b|
          messaging.t("hwf_pages.income_benefits.labels.benefits.#{b}")
        end
      end
    end
  end
end
