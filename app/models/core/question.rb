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

  class Question < BaseModel
    translates :title, :text, fallbacks_for_empty_translations: true

    store_accessor :settings, :template

    scope :required, -> { where(required: true) }

    belongs_to :parent_question, class_name: 'Question', foreign_key: :parent_id

    has_many :substitutions
    has_many :substitutions_campaigns, through: :substitutions
    has_many :campaign_questions
    has_many :campaigns, through: :campaign_questions
    has_many :quota

    before_validation :generate_key, unless: -> (q) { q.key.present? }

    validates :key,
      presence: true,
      allow_blank: false,
      uniqueness: true,
      format: { with: /\A[a-z0-9_]+\z/ }

    validates :settings, settings: true
    validates :kind, presence: true

    def answers
      {}.tap do |hash|
        campaign_question_answers.each do |answer|
          hash[answer.id] = answer.text
        end
      end
    end

    def campaign_question_answers
      ::Core::CampaignQuestionAnswer.
        where(campaign_question_id: campaign_question_ids).
        includes(answerable: :translations).
        order(:answerable_id).
        map(&:answerable).
        uniq.compact
    end

    def campaign_question_ids
      states = %i(active previewing)
      active_campaign_ids = ::Core::Campaign.with_state(states).pluck(:id)

      campaign_questions.where(campaign_id: active_campaign_ids).pluck(:id)
    end

    def redirect_object
      parent_question.try(:redirect_object) || self
    end

    private

    def generate_key
      loop do
        self.key = "#{ kind }_#{ SecureRandom.hex.first(8) }"
        break unless self.class.exists?(key: key)
      end
    end
  end
end
