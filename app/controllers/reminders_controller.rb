class RemindersController < ApplicationController

  def create
    @habit = Habit.find_by(id: params[:habit_id])
    @reminder = Reminder.new(reminder_params)
    @reminder.habit = @habit
    if @reminder.save
      render json: @reminder, status: 201
    else
      render json: @reminder.errors, status: 422
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:answer)
  end

end