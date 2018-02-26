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
    @entry = Entry.new
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
    params.require(:entry).permit(:duration, :date, :note, :activity_id)
  end

  def convert_params_to_proper_format
    if params[:entry][:date].present?
      params[:entry][:date] = Date.parse(params[:entry][:date]).strftime("%Y-%m-%d")
    end
  end

  def load_user_entries
    @entry = current_user.entries.find(params[:id])
  end
end
