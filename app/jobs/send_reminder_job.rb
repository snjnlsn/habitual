### Using this requires token mangemenet.

class SendReminderJob < ApplicationJob
  queue_as :default

  def perform(habit)
    account_sid = ENV["TWILIO_SID"] # Your Account SID from www.twilio.com/console
    auth_token = ENV["TWILIO_TOKEN"]   # Your Auth Token from www.twilio.com/console
    habit = habit

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
      body: "It's time to #{habit}",
      to: "3126109383",    # Number to be sent to, use nums as a string w/o any other chars
      from: ENV["TWILIO_NUMBER"])  # Our Twilio number
  end
end
