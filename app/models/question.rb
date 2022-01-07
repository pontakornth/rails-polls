class Question < ApplicationRecord
  has_many :choices
  def can_vote
    end_date - Time.now >= 0
  end
end
