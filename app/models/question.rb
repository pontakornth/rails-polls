class Question < ApplicationRecord
  has_many :choices
  validates :question_text, :end_date, presence: true
  validate :not_past
  def can_vote
    end_date - Time.now >= 0
  end

  def not_past
    errors.add(:end_date, "can't be in the past") if created_at && end_date < created_at
  end
end
