class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :convert_params_to_proper_format, only: [:create, :update]
  before_action :load_user_entries, only: [:edit, :update, :destroy]
  before_action :load_user_activity, only: [:create]

  def index
    @entries = current_user.entries
    @date = params[:date].present? ? Date.strptime(params[:date], '%Y-%m-%d') : Date.current
    @entries_by_date = @entries.where(date: @date)
    @daily_sum = @entries_by_date.sum(:duration)
  end

  def new
    @activities = current_user.activities
    @entry = Entry.new(duration_hours: 0, duration_minutes: 0, duration_seconds: 0, date: Date.today)
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.activity = @activity
    if @entry.save
      redirect_to tracking_path, flash: { success: "Entry was added." }
    else
      @activities = current_user.activities
      flash.now[:error] = "There was an error creating the entry."
      render "new"
    end
  end

  def edit
    # show duration to user in hours, minutes, and seconds
    @entry.duration_hours = "%02d" % (@entry.duration / 3600)
    @entry.duration_minutes = "%02d" % (@entry.duration / 60 % 60)
    @entry.duration_seconds = "%02d" % (@entry.duration % 60)
  end

  def update
    if @entry.update(entry_params)
      flash[:success] = "Entry was updated."
      redirect_to reports_path(date: @entry.date)
    else
      flash.now[:error] = "There was an error updating the entry. #{@entry.errors.full_messages.to_sentence}."
      render "edit"
    end
  end

  def destroy
    if @entry.destroy
      redirect_to reports_path(date: @entry.date)
    else
      flash.now[:error] = "There was an error deleting the entry."
      redirect_to reports_path(date: @entry.date)
    end
  end


  private
    def entry_params
      params.require(:entry).permit(:duration, :duration_hours, :duration_minutes, :duration_seconds, :date, :note)
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

    # ensure that activity belongs to current user
    def load_user_activity
      @activity = current_user.activities.find(params[:entry][:activity_id])
    end
end
