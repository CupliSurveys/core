module Core
  # Define answer for campaign question
  #
  class CampaignQuestionAnswer < ActiveRecord::Base
    belongs_to :campaign_question
    has_one :question, through: :campaign_question
    belongs_to :answerable, polymorphic: true

    validates :campaign_question_id, presence: true
    validates :answerable_id,
      presence: true,
      uniqueness: { scope: %i(campaign_question_id) }
  end
end
