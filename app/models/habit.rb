class Habit < ApplicationRecord
  belongs_to :user
  has_many :reminders, dependent: :destroy

  validates_presence_of :name, :reminder_frequency, :reminder_time, :user_id
end