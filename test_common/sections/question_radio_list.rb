require_relative 'question_section'
module Calculator
  module Test
    class QuestionRadioListSection < QuestionSection
      def set(value)
        within @root_element do
          choose(value)
        end
      end
    end
  end
end
