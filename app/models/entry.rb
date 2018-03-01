class Entry < ApplicationRecord
  belongs_to :activity
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  # Added because user can enter time in hours/minutes/seconds, but :durations is stored in seconds
  attr_accessor :duration_hours, :duration_minutes, :duration_seconds
end
