class Habit < ApplicationRecord
  belongs_to :user
  has_many :reminders, dependent: :destroy

  validates_presence_of :name, :reminder_frequency, :reminder_time, :user_id

  def accepted_reminders
    self.reminders.where("answer = 'yes'")
  end

  def declined_reminders
    self.reminders.where("answer = 'no'")
  end

  def declined_percentage
    self.declined_reminders.count / self.reminders.count.to_f
  end

  def accepted_percentage
    self.accepted_reminders.count / self.reminders.count.to_f
  end

  def get_stats
    {
      totalReminders: self.reminders.count.to_s,
      yesReminders: self.accepted_reminders.count.to_s,
      noReminders: self.declined_reminders.count.to_s,
      percentageDeclined: self.declined_percentage.to_s,
      percentageAccepted: self.accepted_percentage.to_s
    }
  end

end