class Activity < ApplicationRecord
  belongs_to :user
  has_many :entries
  validates :name, presence: true, uniqueness: { scope: :user_id }
end
