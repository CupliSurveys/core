module Core::Concerns
  module CampaignDelegations
    extend ActiveSupport::Concern

    included do
      delegate :full_name, to: :user, prefix: true
      delegate :locale, to: :user, prefix: true
      delegate :email, to: :user, prefix: true
    end
  end
end
