class AddQuestionIdToChoice < ActiveRecord::Migration[6.1]
  def change
    add_column :choices, :question_id, :integer
    add_index :choices, :question_id
  end
end
