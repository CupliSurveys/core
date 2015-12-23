module Core
  class App < BaseModel
    include Core::Concerns::HasApiKeys
    include Core::Concerns::Roleable

    ROLES = %w[private public]

    validates :name,
      presence: true,
      uniqueness: true
  end
end
