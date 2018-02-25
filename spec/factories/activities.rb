FactoryBot.define do
  factory :activity do
    association :user, factory: :user
    name "writing tests"
  end
end
