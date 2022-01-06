class AddEndDateToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :end_date, :datetime
  end
end
