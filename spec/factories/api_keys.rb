FactoryGirl.define do
  factory :api_key, class: Core::ApiKey do
    owner { create :admin_user }
    sequence(:expires_at) { 30.minutes.from_now }

    trait :for_user do
      owner { create :user }
    end
  end
end
