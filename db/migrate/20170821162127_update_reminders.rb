class UpdateReminders < ActiveRecord::Migration[5.1]
  def change
    add_column :reminders, :formatted_date, :string
  end
end
