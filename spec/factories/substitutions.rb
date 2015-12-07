FactoryGirl.define do
  factory :substitution, class: Core::Substitution do
    campaign { find_or_create(:campaign) }
    question { find_or_create(:question) }

    trait :age do
      question { find_or_create(:age_question) }
      settings do
        {
          key: :stf_age,
          rules: [
            { values: (17..25).to_a, substitute_to: :adult }
          ]
        }
      end
    end

    factory :age_substitution, parent: :substitution, traits: [:age]
  end
end
