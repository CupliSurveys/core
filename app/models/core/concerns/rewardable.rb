module Core::Concerns
  # This module implements the functionality of roles
  module Rewardable
    extend ActiveSupport::Concern

    included do
      has_many :reward_associations,
        as: :rewardable,
        dependent: :destroy
      has_many :rewards,
        through: :reward_associations
    end
  end
end
