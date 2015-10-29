module Core
  # Define campaign model
  #
  class Campaign < BaseModel
    include Core::Concerns::CampaignAssociations
    include Core::Concerns::CampaignDelegations
    include Core::Concerns::CampaignValidations
    include Core::Concerns::CampaignStateMachine

    include Core::Concerns::HasDefaultsQuestions

    store_accessor :settings

    has_paper_trail only: %i(state)
  end
end
