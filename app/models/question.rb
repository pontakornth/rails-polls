class Question < ApplicationRecord
  has_many :choices
  validates :question_text, :end_date, presence: true
  def can_vote
    end_date - Time.now >= 0
  end
end
