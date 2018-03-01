class Activity < ApplicationRecord
  belongs_to :user
  has_many :entries
  validates :name, presence: true, uniqueness: { scope: [:user_id, :is_deleted] }

  scope :deleted, -> { where(is_deleted: true) }

  def soft_delete
    self.update_attribute :is_deleted, true
  end
end
