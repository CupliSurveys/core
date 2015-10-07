module Core
  # Define question for campaign
  #
  # @see Campaign Campaign model
  # @see Question Question model
  #
  # @!attribute [rw] campaign_id
  #   @return [Integer] {Campaign} ID
  # @!attribute [rw] question_id
  #   @return [Integer] {Question} ID
  # @!attribute [rw] settings
  #   Options:
  #     - **:question_type** (*String*) Defining type of the question.
  #       Available values:
  #         * 'age'
  #         * 'gender'
  #         * 'city_id' - Location question
  #         * 'single' - Base single choise question
  #         * 'multiple' - Base multiple choise question
  #         * 'number_input' - Base number input question
  #     - **:shuffled_answers** (*Boolean*) Sequence of showing answers to user:
  #       "as is" of shaffled
  #   @return [Hash] Campaign question settings
  class CampaignQuestion < ActiveRecord::Base
    include Core::Concerns::CampaignQuestionAssociations

    around_save :build_answers

    validates :campaign_id, presence: true

    # Initialize method
    #
    # @param params [Hash] Options for object initialization
    # @option params [Integer] :campaign_id Campaign id
    # @option params [Integer] :question_id Question id
    # @option params [Hash] :settings Optional question settings
    # @option params [Array<Hash>] Answer attributes (see Answer)
    #
    def initialize(params = {})
      @answer_objects = params.fetch(:answers, [])
      params.delete(:answers)
      super(params)
    end

    # Update record method
    #
    # @param (see #initialize)
    #
    # @return [Boolean] true if updated successfully
    # @raise [ActiveRecord::StatementInvalid] if params contains invalid values
    #
    def update(params)
      @answer_objects = params.fetch(:answers, [])
      params.delete(:answers)
      super(params)
    end

    private

    # Builds answers after save action
    #
    def build_answers
      ActiveRecord::Base.transaction do
        yield
        find_or_create_answers.each do |answer_type, answer_records|
          send("#{ answer_type }=", answer_records)
        end
        raise ActiveRecord::RecordInvalid unless valid?
      end
    end

    # Finds existed answer or creates new one
    #
    # @return [Answer, City, Region, Country] Answerable object
    #
    def find_or_create_answers
      answers = { answers: [], compound_regions: [] }

      @answer_objects.each do |ans|
        answer = answerify(ans)
        answer_record = find_answer(answer) || create_answer(answer)
        next unless answer_record
        answers[answer[:type].pluralize.to_sym] ||= []
        answers[answer[:type].pluralize.to_sym] << answer_record
      end
      answers
    end

    # Set answer type if not defined
    #
    # @param [Hash] answer Answer data
    #
    # @return [Hash]
    #
    def answerify(answer)
      res = answer.symbolize_keys
      res[:type] ||= 'answer'
      res
    end

    # Finds existed answer
    #
    # @param [Hash] answer Answer data
    #
    # @return [Answer, City, Region, Country] Answerable object
    #
    def find_answer(answer)
      class_name = answer[:type].classify.constantize

      exact = class_name.find_by(id: answer[:id])
      return exact if exact

      ids = class_name.search(answer[:text], exact_match: true).ids
      class_name.find_by_id(ids & [answer[:id].to_s])
    end

    # Creates new answer
    #
    # @param [Hash] answer Answer data
    #
    # @return [Answer, City, Region, Country] Answerable object
    #
    def create_answer(answer)
      return unless answer[:type] == 'answer'
      Answer.create!(answer.slice(:text, :settings))
    end
  end
end
