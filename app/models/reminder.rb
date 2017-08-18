class Reminder < ApplicationRecord
  belongs_to :habit

  validates_presence_of :habit_id, :answer
end