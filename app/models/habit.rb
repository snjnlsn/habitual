class Habit < ApplicationRecord
  belongs_to :user
  has_many :reminders, dependent: :destroy
  include ActionView::Helpers::TextHelper

  validates_presence_of :name, :reminder_frequency, :reminder_time, :user_id

  def accepted_reminders
    self.reminders.where("answer = 'yes'")
  end

  def declined_reminders
    self.reminders.where("answer = 'no'")
  end

  def declined_percentage
    ((self.declined_reminders.count / self.reminders.count.to_f) * 100).to_i
  end

  def accepted_percentage
    ((self.accepted_reminders.count / self.reminders.count.to_f) * 100).to_i
  end

  def time_since_creation
    seconds = Time.now - self.created_at
    days = seconds.to_i / (86400)
    hours = (seconds.to_i % 86400) / 3600
    case
    when days < 1 && hours < 1
      "less than an hour"
    when days < 1
      pluralize(hours, 'hour')
    else
      pluralize(days, 'day') + " " + pluralize(hours, 'hour')
    end
  end

  def on_hot_streak
    return true if self.reminders[-1].answer + self.reminders[-2].answer + self.reminders[-3].answer + self.reminders[-4].answer + self.reminders[-5].answer == "yesyesyesyesyes"
  end

  def get_stats
    {
      pieChart:[
        {number:  self.accepted_percentage,
         name: "Yes"},
        {number: self.declined_percentage,
         name: "No"}
         ],
      totalReminders:   self.reminders.count.to_s,
      yesReminders:     self.accepted_reminders.count.to_s,
      noReminders:      self.declined_reminders.count.to_s,
      habitTime:        self.time_since_creation,
    }
  end

  def random_times
    random_times = []
    counter = 0
    span = self.end_time - self.reminder_time
    interval = span / reminder_frequency
    reminder_frequency.times do
      seconds = rand(counter..counter + interval)
      counter += interval
      random_times << Time.now + seconds
    end
    random_times
  end

end
