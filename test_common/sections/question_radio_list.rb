require_relative 'question_section'
module Calculator
  module Test
    class QuestionRadioListSection < QuestionSection
      def set(value)
        choose(value)
      end
    end
  end
end
