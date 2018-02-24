class Activity < ApplicationRecord
  # TODO: add validation, that limits the scope to current_user
  belongs_to :user
end
