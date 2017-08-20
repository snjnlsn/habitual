require 'rails_helper'

RSpec.describe User, type: :model do


  describe "attributes" do

    it "has a readable user_identifier" do
      user = User.new(user_identifier: "12345")

      expect(user.user_identifier).to eq '12345'
    end

  end

  describe "validations" do

    it "is not valid without an identifier" do
      user = User.new

      expect(user.valid?).to be false
    end

  end

end