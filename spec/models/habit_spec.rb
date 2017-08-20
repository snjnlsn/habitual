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

end
