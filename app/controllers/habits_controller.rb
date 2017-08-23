class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :update, :destroy]
  before_action :set_user, only: [:index, :create]

  def index
    @user = User.first
    if @user
      render json: @user.habits, status: 201
    end
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user = @user
    if @habit.save
      # commented out b/c it's token reliant.
      # time = DateTime.parse("August 22, 2017 11:36 -0500") # depends on the format of the time we're setting reminders.
      # SendReminderJob.set(wait_until: time).perform_later(@habit.name)
      render json: @habit, status: 201
    else
      render json: @habit.errors, status: 422
    end
  end

  def show
    if @habit
      if @habit.reminders.any?
        render json: {stats: @habit.get_stats, name: @habit.name, reminders: @habit.reminders}, status: 201
      else
        render json: {name: @habit.name}, status: 201
      end
    else
      render status: 422
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

  def destroy
    @habit.destroy
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :reminder_frequency, :reminder_time)
  end

  def set_user
    @user = User.find_or_create_by(user_identifier: params[:user_id])
  end

  def set_habit
    @habit = Habit.find_by(id: params[:id])
  end

end
