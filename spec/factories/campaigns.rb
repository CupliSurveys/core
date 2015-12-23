FactoryGirl.define do
  factory :simple_campaign, class: Core::Campaign do
    user
    name { SecureRandom.hex(4) }
    survey_url { Faker::Internet.url }
    link_builder { Faker::Lorem.word }
    priority { 1 + rand(5) }
    deadline_at { (1..4).to_a.sample.weeks.from_now }
    settings foo: :bar

    trait :substitution do
      after(:build) do |campaign|
        city_question = find_or_create(:question, key: :city_id)
        age_question = find_or_create(:question, key: :age)
        gender_question = find_or_create(:gender_question, key: :gender)

        create(:substitution, campaign: campaign, question: age_question)
        create(:substitution, campaign: campaign, question: gender_question)
        create(
          :substitution,
          campaign: campaign,
          question: city_question,
          settings: { key: :city }
        )
      end
    end
  end

  factory :campaign,
    parent: :simple_campaign,
    traits: [:substitution]
end
