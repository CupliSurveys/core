FactoryGirl.define do
  factory :question, class: Core::Question do
    title { Faker::Lorem.sentence(10) }
    kind 'numeric'
    key { SecureRandom.hex[0..8] }

    trait :city do
      key :city_id
    end

    trait :age do
      key :age
    end

    trait :gender do
      key :gender
    end

    trait :collector do
      kind 'custom'
      key :collector
    end

    trait :random do
      kind :string
      settings do
        {
          values: {
            Faker::Lorem.word => Faker::Lorem.word,
            Faker::Lorem.word => Faker::Lorem.word
          },
          template: %w(radio).sample # TODO: checkbox
        }
      end
    end

    factory :custom_question, parent: :question, traits: [:random]
    factory :city_question, parent: :question, traits: [:city]
    factory :age_question, parent: :question, traits: [:age]
    factory :gender_question, parent: :question, traits: [:gender]
    factory :collector_question, parent: :question, traits: [:collector]
  end
end
