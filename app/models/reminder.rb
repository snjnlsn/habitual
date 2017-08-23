class Reminder < ApplicationRecord
  belongs_to :habit
  validates_presence_of :habit_id, :answer
  after_create :created_at_format

  def created_at_format
    self.formatted_date = self.created_at.strftime("%A, %d %b %Y %l:%M %p")
  end

end
