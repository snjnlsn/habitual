class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.integer :habit_id, null: false
      t.string :answer, null: false

      t.timestamps
    end
  end
end
