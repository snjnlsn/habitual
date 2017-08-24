class RandomsController < ApplicationController

  def random
    @habit = Habit.new(habit_params)
    @habit.user = User.first
    if @habit.save
      render json: {habit: @habit, array: @habit.random_times}, status: 201
    else
      render json: @habit.errors, status: 422
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :reminder_frequency, :reminder_time, :end_time)
  end
end
