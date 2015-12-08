FactoryGirl.define do
  factory :answer, class: Core::Answer do
    text { Faker::Lorem.word }
    settings { { min: rand(50).to_s, max: (rand(50) + 50).to_s } }
  end
end
