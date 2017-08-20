require 'rails_helper'

RSpec.describe Reminder, type: :model do

  describe "validations" do

    it "is not valid without a habit" do
      reminder = Reminder.new(answer: "yes")

      expect(reminder.valid?).to be false
    end

    it "is not valid without an answer" do
      reminder = Reminder.new(habit_id: 1)

      expect(reminder.valid?).to be false
    end

    it "can be attributed to a habit" do
      u = User.create(user_identifier: "12345")
      u.habits << Habit.new(name: "sleep", reminder_time: Time.now, reminder_frequency: 2)
      reminder = Reminder.new( answer: "yes")
      u.habits.first.reminders << reminder
      expect(u.habits.first.reminders).to include reminder
    end

  end

end
