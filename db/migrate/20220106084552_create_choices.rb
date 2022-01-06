class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.string :choice_text
      t.integer :votes

      t.timestamps
    end
  end
end
