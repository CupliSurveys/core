module Core::Concerns
  # Campaign question associations
  #
  module CampaignQuestionAssociations
    extend ActiveSupport::Concern

    included do
      belongs_to :campaign
      belongs_to :question
      has_many :campaign_question_answers, dependent: :destroy
      has_many :answers,
        through: :campaign_question_answers,
        source: :answerable,
        source_type: 'Core::Answer'
      has_many :compound_regions,
        through: :campaign_question_answers,
        source: :answerable,
        source_type: 'Core::CompoundRegion'

      # Related substitution
      # @see Substitution
      #
      # @return [Substitution]
      def substitution
        Substitution.find_by(campaign_id: campaign_id, question_id: question_id)
      end
    end
  end
end
