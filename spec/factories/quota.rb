FactoryGirl.define do
  factory :quotum, class: Core::Quotum do
    campaign { create(:campaign) }
    question { create(:question) }
    target 100
    completed 0
    parent_ids [123]
    settings do
      {
        type: 'geo_area_ids',
        value: [1, 2]
      }
    end

    trait :city do
      question { find_or_create(:city_question) }
      settings(value: [1])
    end
  end

  factory :city_quotum, parent: :quotum, traits: [:city]
end
