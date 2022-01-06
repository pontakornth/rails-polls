class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.string :choice_text
      t.number :votes

      t.timestamps
    end
  end
end
