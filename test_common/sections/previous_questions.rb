require_relative '../messaging'
require_relative './previous_question'
module Calculator
  module Test
    class PreviousQuestionsSection < BaseSection
      ALL_QUESTIONS = [:marital_status, :court_fee, :disposable_capital, :income_benefits].freeze
      include ::Calculator::Test::I18n

      section :marital_status, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t("hwf_components.previous_questions.marital_status.label")
      section :court_fee, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.court_fee.label')
      section :date_of_birth, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.date_of_birth.label')
      section :partner_date_of_birth, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.partner_date_of_birth.label')
      section :disposable_capital, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.disposable_capital.label')
      section :income_benefits, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.income_benefits.label')
      section :number_of_children, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.number_of_children.label')
      section :total_income, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, t('hwf_components.previous_questions.total_income.label')

      def disabled?
        ALL_QUESTIONS.all? {|q| send(q).disabled?}
      end

    end
  end
end

