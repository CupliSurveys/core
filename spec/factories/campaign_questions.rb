FactoryGirl.define do
  factory :campaign_question, class: Core::CampaignQuestion do
    campaign
    question
    settings { { key: Faker::Lorem.word } }
  end
end
