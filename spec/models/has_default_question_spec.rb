require 'spec_helper'
describe 'HasDefaultQuestions' do
  let(:campaign) { create(:campaign, state: :active) }
  let!(:collector) { create(:question, :collector) }

  describe 'default asl' do
    it 'campaign questions' do
      expect(campaign.campaign_questions.pluck("settings -> 'question_type'")).
        to match(%w(city_id age gender) << nil)
    end

    it 'campaign_question_answers for gender question' do
      age_campaign_question =
        campaign.campaign_questions.
          find_by("settings ->> 'question_type' = 'gender'")
      expect(age_campaign_question).to be_kind_of(Core::CampaignQuestion)
    end

    it 'gender answers' do
      age_campaign_question =
        campaign.reload.campaign_questions.
          find_by("settings ->> 'question_type' = 'gender'")

      question = age_campaign_question.question

      expect(question.key).to eq('gender')
      expect(question.answers.count).to eq(2)
    end

    it 'generates empty collector' do
      expect(campaign.quota.first.question.key).to eq('collector')
    end
  end
end
