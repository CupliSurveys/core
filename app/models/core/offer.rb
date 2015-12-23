module Core
  # Defines offer model
  #
  class Offer < BaseModel
    include Core::Concerns::Rewardable

    store_accessor :settings

    belongs_to :provider

    validates :provider,
      presence: true
    validates :cost_model,
      presence: true,
      inclusion: { in: %w(cpp cpa cpm cpc) }
    validates :price,
      presence: true,
      numericality: { greater_than_or_equal_to: 0 }
    validates :settings,
      settings: true
    validates :name,
      not_nil: true

    before_save :normalize_data

    private

    def normalize_data
      self.locale = locale.downcase
    end
  end
end
