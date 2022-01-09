class AddQuestionAssociationToVote < ActiveRecord::Migration[6.1]
  def change
    add_reference :votes, :question, null: false, foreign_key: true
  end
end
