FactoryGirl.define do
  factory :compound_region, class: Core::CompoundRegion do
    sequence(:name) { |n| "Compound region #{ n }" }
    settings { { geoname_ids: [123] } }
  end
end
