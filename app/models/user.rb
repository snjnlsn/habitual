class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :reminders, through: :habits

  validates_presence_of :user_identifier
end