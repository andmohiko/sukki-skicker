FactoryBot.define do
  factory :sukipi do
    association :user
    name { 'Bob' }
    suki { 0 }
    user_id { 1 }
  end
end
