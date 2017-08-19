require 'rails_helper'

RSpec.describe RemindersController, type: :controller do

  before(:each) do
   @user = User.create!( user_identifier: '12345', name: "Dog" )
   @habit = Habit.create!(name: "Dog", reminder_frequency: 1, reminder_time: Time.now, user_id: @user.id )
  end



  describe "Reminder is valid" do

    xit "returns status 201" do
      post "habits/#{@habit.id}/reminders" => 'reminders#create'#, params: { reminder: { answer: "Dog" } }
      expect(response).to have_http_status 201

    end

  end


end
