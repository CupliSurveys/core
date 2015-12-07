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
  end
end
