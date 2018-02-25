require 'rails_helper'

RSpec.describe User, type: :model do
  it "allows a user to be created" do
    user = create(:user)

    expect(user).to have_attributes email: "john@example.com"
    expect(user).to be_valid
    expect(user.persisted?).to be true
  end

  it "can access entries through activities" do
    entry = create(:entry)
    user = entry.activity.user

    expect(user.activities).to include entry.activity
    expect(user.entries).to include entry
  end
end
