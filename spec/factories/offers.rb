FactoryGirl.define do
  factory :offer, class: Core::Offer do
    provider
    remote_offer_id 1
    settings foo: :bar
    cost_model 'cpa'
    price { rand(1000) }
    extra_motivation_cost { rand(100) }
  end
end
