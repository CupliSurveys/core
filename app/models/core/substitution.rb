module Core
  class Substitution < BaseModel
    belongs_to :campaign
    belongs_to :question

    validates :campaign,
      presence: true

    validates :question,
      presence: true

    validates :settings,
      settings: true
  end
end
