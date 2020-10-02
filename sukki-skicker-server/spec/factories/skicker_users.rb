FactoryBot.define do
  factory :skicker_user do
    association :user
    association :skicker
  end
end
