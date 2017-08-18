class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :update]
  before_action :set_user, only: [:index, :create]

  def index
    if @user
      render json: @user.habits, status: 201
    end
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user = @user
    if @habit.save
      render json: @habit, status: 201
    else
      render json: @habit.errors, status: 422
    end
  end

  def show
    if @habit
      render json: @habit.reminders, status: 201
    else
      status: 422
    end
  end

  def update
    @habit.update_attributes(habit_params)
    if @habit.save
      render json: @habit, status: 201
    else
      render json: @habit.errors, status: 422
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :reminder_frequency, :reminder_time)
  end

  def set_user
    @user = User.find_by(user_identifier: params[:user_identifier])
  end

  def set_habit
    @habit = Habit.find_by(id: params[:id])
  end

end