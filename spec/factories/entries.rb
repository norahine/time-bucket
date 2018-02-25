FactoryBot.define do
  factory :entry do
    association :activity, factory: :activity
    duration 2000
    date Date.new(2018,2,25)
    note "lorem ipsum"
  end
end


