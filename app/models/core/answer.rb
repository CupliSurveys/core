module Core
  # Define common type of question answer
  #
  # @see CampaignQuestion Campaign question model
  # @see CampaignQuestionAnswer Linking model between CampaignQuestion and
  #   Answer
  #
  # @!attribute [rw] text
  #   @return [String] Searchable Answer text
  # @!attribute [rw] settings
  #   Options:
  #     - **:min_val** (*Integer*) Range min value
  #     - **:max_val** (*Integer*) Range max value
  #   @return [Hash] Nonsearchable answer parameters
  class Answer < BaseModel
    translates :text, fallbacks_for_empty_translations: true

    validates :settings,
      settings: true
  end
end
