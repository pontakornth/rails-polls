class Vote < ApplicationRecord
  belongs_to :choice
  belongs_to :user
  belongs_to :question
end
