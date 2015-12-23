FactoryGirl.define do
  factory :user, class: Core::User do
  end

  factory :admin_user, parent: :user
end
