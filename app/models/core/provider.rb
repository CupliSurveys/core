module Core
  class Provider < BaseModel
    has_many :offers

    validates :name, presence: true
    validates :slug, presence: true
    validates :settings, settings: true
    validates :handler, presence: true
  end
end
