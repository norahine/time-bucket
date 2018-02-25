FactoryBot.define do
  factory :user do
    email "john@example.com"
    password "password"
    # Necessary because password confoirmation is not stored in the database
    after(:build) { |u| u.password_confirmation = u.password }
  end
end
