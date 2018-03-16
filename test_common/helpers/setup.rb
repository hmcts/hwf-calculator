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
        unless QUESTIONS.include?(question)
          raise "Unknown question :#{question} - Must be one of #{QUESTIONS.join(', ')}"
        end
        start_calculator_session
        QUESTIONS[1..QUESTIONS.index(question) - 1].each do |q|
          answer_question(q)
        end
      end

      def answer_question(question)
        send "answer_#{question}_question".to_sym
      end

      def answer_disposable_capital_question
        disposable_capital_page.disposable_capital.set(user.disposable_capital)
        disposable_capital_page.next
      end

      def answer_date_of_birth_question
        date_of_birth_page.date_of_birth.set(user.date_of_birth)
        if user.partner_date_of_birth.present?
          date_of_birth_page.partner_date_of_birth.set(user.partner_date_of_birth)
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
        load_start_page
        start_page.start_session
      end

      def load_start_page(in_language: ::Calculator::Test::Messaging.instance.current_locale)
        my_page = start_page
        my_page.load_page
        case in_language
        when :cy then my_page.switch_to_welsh
        when :en then nil
        else raise "We only support languages en and cy - #{in_language} is not supported"
        end
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
        return self.user = OpenStruct.new if user_name.to_sym == :anonymous
        self.user = personas.fetch(user_name)
        user.marital_status = user.marital_status.to_sym
        user.date_of_birth = (user.age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')
        if user.partner_age.present?
          user.partner_date_of_birth = (user.partner_age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')
        end
        return if user.income_benefits.nil?
        user.income_benefits.map!(&:to_sym)
      end

      def all_questions
        QUESTIONS - [:all]
      end
    end
  end
end
