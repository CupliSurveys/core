module Core
  class RewardAssociation < BaseModel
    belongs_to :reward
    belongs_to :rewardable, polymorphic: true

    validates :reward_id, presence: true
    validates :rewardable_id,
      presence: true,
      uniqueness: { scope: %i(reward_id rewardable_type) }
  end
end
