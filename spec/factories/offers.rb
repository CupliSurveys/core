# == Schema Information
#
# Table name: offers
#
#  id              :integer          not null, primary key
#  provider_id     :integer
#  remote_offer_id :integer
#  settings        :hstore           default({}), not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_offers_on_provider_id      (provider_id)
#  index_offers_on_remote_offer_id  (remote_offer_id)
#  index_offers_on_settings         (settings)
#

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
