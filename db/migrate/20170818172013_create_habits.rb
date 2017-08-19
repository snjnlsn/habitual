class CreateHabits < ActiveRecord::Migration[5.1]
  def change
    create_table :habits do |t|
      t.string :name, null: false
      t.boolean :active, default: true
      t.integer :user_id, null: false
      t.integer :reminder_frequency
      t.timestamp :reminder_time

      t.timestamps
    end
  end
end
