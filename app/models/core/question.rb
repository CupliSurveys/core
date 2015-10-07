module Core
  # Stores question for prescreen
  # @attribute key
  #   Key like `city_id` or `gender`
  # @attribute title
  #   User-defined question title
  # @attribute [Hash] settings
  #   Stores settings for rendering
  #
  # @example Question for radio input type
  #   Question.create!(
  #     title: 'Коэффициент полезного действия нагревательного прибора',
  #     description: 'Есть сферический кипятильник в сферическом чайнике. КПД?'
  #     settings: {
  #       values: { 100 => '100%', 50 => '50%', 20 => '20%' },
  #       template: :radio
  #     }
  #   )

  class Question < ActiveRecord::Base
    translates :title, :text, fallbacks_for_empty_translations: true

    store_accessor :settings

    has_many :substitutions
    has_many :substitutions_campaigns, through: :substitutions
    has_many :campaign_question_answers
    has_many :campaigns, through: :campaign_question_answers

    before_validation :generate_key, unless: -> (q) { q.key.present? }

    validates :key,
      presence: true,
      allow_blank: false,
      uniqueness: true,
      format: { with: /\A[a-z0-9_]+\z/ }

    validates :kind, presence: true

    private

    def generate_key
      loop do
        self.key = "#{ kind }_#{ SecureRandom.hex.first(8) }"
        break unless self.class.exists?(key: key)
      end
    end
  end
end
