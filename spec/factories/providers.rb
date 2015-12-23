FactoryGirl.define do
  factory :provider, class: Core::Provider do
    name { Faker::Company.name }
    utm_hash { SecureRandom.hex[0..7] }
    slug { %w(fotostrana plan_b).sample }
    handler { Faker::Lorem.word }
  end
end
