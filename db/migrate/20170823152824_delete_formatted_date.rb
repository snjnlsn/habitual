class DeleteFormattedDate < ActiveRecord::Migration[5.1]
  def change
    remove_column :reminders, :formatted_date, :string
  end
end
