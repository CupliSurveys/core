module Core
  # Define campaign model
  #
  class Campaign < ActiveRecord::Base
    include Core::Concerns::CampaignAssociations
    include Core::Concerns::CampaignDelegations
    include Core::Concerns::CampaignValidations
    include Core::Concerns::CampaignStateMachine

    include Core::Concerns::HasAslQuestions

    store_accessor :settings

    has_paper_trail only: %i(state)
  end
end