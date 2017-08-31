require 'rails_helper'

RSpec.describe Habit, type: :model do

    before(:each) do
      @user = User.create(user_identifier: "12345")
    end

  describe "validations" do

    it "is valid with a name, reminder frequency, reminder time and user_id" do
      habit = @user.habits.create(user_id: 1, reminder_time: Time.now, reminder_frequency: 1, name: "drink more water")
      expect(habit.valid?).to be true
    end

    it "is valid without an end time" do
      habit = @user.habits.create(reminder_time: Time.now, reminder_frequency: 1, name: "drink more water", end_time: nil)
      expect(habit.valid?).to be true
    end

    it "is valid with an end time" do
      habit = @user.habits.create(reminder_time: Time.now, reminder_frequency: 1, name: "drink more water", end_time: (Time.now + 20))
      expect(habit.valid?).to be true  
    end

    it "is not valid without a name" do
      habit = Habit.new(user_id: 1, reminder_time: Time.now, reminder_frequency: 3)

      expect(habit.valid?).to be false
    end

    it "is not valid without a user" do
      habit = Habit.new(name: 'drink water', reminder_time: Time.now, reminder_frequency: 3)

      expect(habit.valid?).to be false
    end

    it "is invalid without a reminder frequency" do
      habit = @user.habits.create(name: 'drink water', reminder_time: Time.now)
      expect(habit.valid?).to be false
    end

    it "is invalid without a reminder time" do
      habit =@user.habits.create(name: 'drink water', reminder_frequency: 3)
      expect(habit.valid?).to be false
    end

  end

  describe "time since creation" do

    xit "returns a correctly pluralized string" do
      # use timecop
      habit = Habit.new(user_id: 1, reminder_time: Time.now, reminder_frequency: 1, name: "drink more water")
    end

    xit "returns a blank string with invalid input" do
      # use timecop
    end
  end

  describe "on a hot streak" do

    before(:each) do
      @hot_habit = @user.habits.create(reminder_time: Time.now, reminder_frequency: 1, name: "drink more water")
    end

    it "returns true if a user has answered yes to their last 5 reminders" do
      5.times do @hot_habit.reminders.create(answer: 'yes') end
      expect(@hot_habit.on_hot_streak).to eq true
    end 

    it "returns falsey if a user has not answered yes to their last 5 reminders" do
      5.times do @hot_habit.reminders.create(answer: 'yes') end
      @hot_habit.reminders.create(answer: 'no')
      expect(@hot_habit.on_hot_streak).to be_falsey
    end

    it "returns falsey in the case of invalid input" do
      5.times do @hot_habit.reminders.create(answer: "junk") end
      expect(@hot_habit.on_hot_streak).to be_falsey
    end

    xit 'returns falsey ig a habit has fewer than 5 reminders' do
    end
  end

  describe "statistics" do
    before(:each) do
      @user   = User.create(user_identifier: "12345")
      @habit  = Habit.create(name: "walk the dog", reminder_time: Time.now, reminder_frequency: 3, user: @user)
      4.times { @habit.reminders << Reminder.new( answer: "yes") }
      6.times { @habit.reminders << Reminder.new( answer: "no") }
    end

    after(:all) do
      Reminder.destroy_all
      User.destroy_all
      Habit.destroy_all
    end

    xit "ignores any values that are not 'yes' or 'no'" do
      @habit.reminders << Reminder.new(answer: "cool")
      expect(@habit.accepted_reminders.count).to eq 4
      expect(@habit.declined_reminders.count).to eq 6
    end

    it "returns all accepted reminders" do
      expect(@habit.accepted_reminders.count).to eq 4
    end

    it "returns all declined reminders" do
      expect(@habit.declined_reminders.count).to eq 6
    end

    context "Percentage" do

      it "returns percentage of reminders that were accepted" do
        expect(@habit.accepted_percentage).to eq 40
      end

      it "returns percentage of reminders that were rejected" do
        expect(@habit.declined_percentage).to eq 60
      end

      it "returns a hash of statistics" do
        stats = @habit.get_stats
        expect(stats[:totalReminders]).to eq "10"
        expect(stats[:yesReminders]).to eq "4"
        expect(stats[:pieChart][1][:number]).to eq 60
      end

    end

  end

  describe "Randomized Times" do
    context "invalid input" do
      before(:each) { @user = User.create user_identifier: "12345" }

      it "returns a single time if no end time is provided" do
        reminder_time = Date.parse("01/01/2017")
        @habit  = Habit.create(name: "walk the dog", reminder_time: reminder_time, reminder_frequency: 1, user: @user)
        expect(@habit.random_times).to include reminder_time 
        expect(@habit.random_times.count).to eq 1
      end

      xit "returns a blank array if reminder num is < 1" do
        @habit  = Habit.create(name: "walk the dog", reminder_time: Time.now, reminder_frequency: 0, user: @user)
        expect(@habit.random_times).to eq []
      end

      xit "returns a blank array if the end time is before start time" do
        @habit  = Habit.create(name: "walk the dog", reminder_time: Time.now, reminder_frequency: 0, user: @user, end_time: Time.now - 10000)
        expect(@habit.random_times).to eq []
      end
    end

    context "valid input" do
      
      it "returns times within a span of 24 hours" do
        reminder_time = Date.parse("01/01/2017")
        next_day = reminder_time + 1
        @habit  = Habit.create(name: "walk the dog", reminder_time: reminder_time, end_time: next_day, reminder_frequency: 1, user: @user)
        expect(@habit.random_times[-1] - @habit.random_times[0]).to be < (60 * 60 * 24)
      end

      xit "returns times within the correct intervals" do
      end
    end
  end

end
