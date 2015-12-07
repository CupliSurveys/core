# == Schema Information
#
# Table name: providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  utm_hash   :string(255)
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_providers_on_slug  (slug)
#

FactoryGirl.define do
  factory :provider, class: Core::Provider do
    name { Faker::Company.name }
    utm_hash { SecureRandom.hex[0..7] }
    slug { %w(fotostrana plan_b).sample }
    handler { Faker::Lorem.word }
  end
end
