require 'rails_helper'

RSpec.describe Habit, type: :model do

  describe "attributes" do

    it "has a readable name" do
      habit = Habit.new(name: "walk the dog")

      expect(habit.name).to eq 'walk the dog'
    end

  end

  describe "validations" do

    it "is not valid without a name" do
      habit = Habit.new(user_id: 1, reminder_time: Time.now, reminder_frequency: 3)

      expect(habit.valid?).to be false
    end

    it "is not valid without a user" do
      habit = Habit.new(name: 'drink water', reminder_time: Time.now, reminder_frequency: 3)

      expect(habit.valid?).to be false
    end

  end

  describe "statistics" do
    before(:each) do
      @user = User.create(user_identifier: "12345")
      @habit = Habit.create(name: "walk the dog", reminder_time: Time.now, reminder_frequency: 3, user: @user)
      4.times do
        @habit.reminders << Reminder.new(answer: "yes")
      end
      6.times do
        @habit.reminders << Reminder.new(answer: "no")
      end
    end

    after(:all) do
      Reminder.destroy_all
      User.destroy_all
      Habit.destroy_all
    end

    it "returns all accepted reminders" do
      expect(@habit.accepted_reminders.count).to eq 4
    end

    it "returns all declined reminders" do
      expect(@habit.declined_reminders.count).to eq 6
    end

    context "Percentage" do

      it "returns percentage of reminders that were accepted" do
        expect(@habit.accepted_percentage).to eq 0.4
      end

      it "returns percentage of reminders that were rejected" do
        expect(@habit.declined_percentage).to eq 0.6
      end

      it "returns a hash of statistics" do
        stats = @habit.get_stats
        expect(stats[:totalReminders]).to eq "10"
        expect(stats[:yesReminders]).to eq "4"
        expect(stats[:percentageDeclined]).to eq "0.6"
      end

    end

  end

end
