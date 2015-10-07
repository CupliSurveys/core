module Core
  # Defines offer model
  #
  class Offer < ActiveRecord::Base
    store_accessor :settings

    belongs_to :campaign
    belongs_to :provider

    validates :provider,
      presence: true
    validates :remote_offer_id,
      presence: true
    validates :cost_model,
      presence: true,
      inclusion: { in: %w(cpp cpa cpm cpc) }
    validates :locale,
      presence: true
    validates :price,
      presence: true,
      numericality: { greater_than_or_equal_to: 0 }

    before_save :normalize_data

    private

    def normalize_data
      self.locale = locale.downcase
    end
  end
end
