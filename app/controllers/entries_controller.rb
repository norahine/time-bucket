class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :convert_params_to_proper_format, only: [:create]
  before_action :load_user_entries, only: [:edit, :update, :destroy]

  def index
    @entries = current_user.entries
    @date = params[:date].present? ? Date.strptime(params[:date], '%Y-%m-%d') : Date.current
    @entries_by_date = @entries.where(date: @date)
  end

  def new
    @activities = current_user.activities
    @entry = Entry.new(duration_hours: 0, duration_minutes: 0, duration_seconds: 0, date: Date.today)
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to tracking_path, flash: { success: "Entry was added." }
    else
      @activities = current_user.activities
      flash.now[:error] = "There was an error creating the entry."
      render "new"
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      flash[:success] = "Entry was updated."
      redirect_to reports_path
    else
      flash.now[:error] = "There was an error updating the entry. " + @entry.errors.full_messages.to_sentence + "."
      render "edit"
    end
  end

  def destroy
    @entry.destroy

    redirect_to reports_path
  end


  private
  def entry_params
    params.require(:entry).permit(:duration, :duration_hours, :duration_minutes, :duration_seconds, :date, :note, :activity_id)
  end

  def convert_params_to_proper_format
    if params[:entry][:date].present?
      params[:entry][:date] = Date.parse(params[:entry][:date]).strftime("%Y-%m-%d")
    end
    hours_in_seconds = params[:entry][:duration_hours].to_i * 3600
    minutes_in_seconds = params[:entry][:duration_minutes].to_i * 60
    params[:entry][:duration] = hours_in_seconds + minutes_in_seconds + params[:entry][:duration_seconds].to_i
  end

  def load_user_entries
    @entry = current_user.entries.find(params[:id])
  end
end
