class Entry < ApplicationRecord
  belongs_to :activity
  validates :duration, presence: true
  validates :date, presence: true
end
