module Core
  class Substitution < ActiveRecord::Base
    belongs_to :campaign
    belongs_to :question

    validates :campaign, presence: true
    validates :question, presence: true
  end
end
