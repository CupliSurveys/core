module Core::Concerns
  # Campaign associations
  #
  module CampaignAssociations
    extend ActiveSupport::Concern

    included do
      belongs_to :user,
        counter_cache: true

      has_many :substitutions, dependent: :destroy
      has_many :substitution_questions,
        through: :substitutions,
        source: :question
      has_many :campaign_questions, dependent: :destroy
      has_many :questions,
        through: :campaign_questions,
        source: :question
      has_many :quota,
        dependent: :destroy
    end
  end
end
