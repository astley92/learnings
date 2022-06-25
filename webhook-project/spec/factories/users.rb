FactoryBot.define do
  factory :user do
    sequence(:email) { "test#{_1}@test.com" }
    sequence(:password) { "123456#{_1}" }
  end
end
