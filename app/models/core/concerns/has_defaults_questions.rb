module Core::Concerns
  # Module HasDefaultsQuestions provides ability to build ASL questions for Campaign
  #   model before it creates
  #
  module HasDefaultsQuestions
    extend ActiveSupport::Concern

    included do
      before_create :build_asl
      before_create :build_collector

      # Creates ASL questions
      #
      def build_asl
        questions_vals = { city_id: nil, age: nil, gender: %w(male female) }
        ::Core::Question.where(key: questions_vals.keys).find_each do |question|
          build_campaign_question(question, questions_vals[question.key.to_sym])
          substitutions.build(question: question)
        end
      end

      # Add quota collector
      #
      def build_collector
        collector = Core::Question.find_by(key: 'collector')
        campaign_questions.build(question: collector)
      end

      # Build question with provided answer options
      #
      # @param [Question] question {Question} object
      # @param [Array<String>] values Array of text answers for question
      #
      # TODO probably should be deleted
      def build_campaign_question(question, values)
        answers = ::Core::Answer.
          with_translations.
          where(core_answer_translations: { text: values }).
          where.not(text: [nil, ''])

        answers_params = answers.map do |a|
          a.attributes.slice(*%w(id settings text))
        end

        campaign_questions.build(
          question: question,
          answers: answers_params,
          settings: { 'question_type': question.key }
        )
      end
    end
  end
end
