class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :convert_params_to_proper_format, only: [:create]

  def index
    @entries= current_user.entries
  end

  def new
    @activities = current_user.activities
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to tracking_path, flash: { succes: "Entry was added." }
    else
      @activities = current_user.activities
      flash.now[:error] = "There was an error creating the entry."
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def entry_params
    params.require(:entry).permit(:duration, :date, :note, :activity_id)
  end

  def convert_params_to_proper_format
    params[:entry][:date] = Date.parse(params[:entry][:date]).strftime("%Y-%m-%d")
  end
end
