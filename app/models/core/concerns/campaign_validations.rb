module Core::Concerns
  module CampaignValidations
    extend ActiveSupport::Concern

    included do
      validates :complete_price,
        numericality: { greater_than_or_equal_to: 0 }

      validates :cr,
        numericality: { greater_than_or_equal_to: 0 }

      validates :deadline_at,
        timeliness: { after: :created_at },
        on: :update

      validates :ecpc,
        numericality: { greater_than_or_equal_to: 0 }

      validates :fill_rate,
        numericality: { greater_than_or_equal_to: 0 }

      validates :name,
        presence: true

      validates :priority,
        numericality: { only_integer: true },
        inclusion: { in: 1..5 }

      validates :user,
        presence: true

      validates :settings,
        settings: true

      validates :remote_campaign_id,
        uniqueness: { scope: :link_builder },
        allow_blank: true
    end
  end
end
