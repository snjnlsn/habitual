class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      # dog =  json: @user.to_json
      # p dog.class
      render json: @user, status: 201
    else
      render json: @user.errors, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_identifier, :name)
  end

end