class AddEndTime < ActiveRecord::Migration[5.1]
  def change
    add_column :habits, :end_time, :timestamp
  end
end
