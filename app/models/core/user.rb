module Core
  class User < BaseModel
    include Core::Concerns::HasApiKeys
    include Core::Concerns::Nameable
    include Core::Concerns::Roleable

    ROLES = %w(admin)

    has_many :campaigns,
      dependent: :destroy

    scope :customers, -> { where('campaigns_count > 0') }
  end
end
