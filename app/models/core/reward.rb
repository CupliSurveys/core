module Core
  # Define reward fo passing survey
  class Reward < BaseModel
    has_many :reward_associations
    has_many :rewardables,
      through: :reward_associations
  end
end
