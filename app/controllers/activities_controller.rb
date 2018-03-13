class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_activity, only: [:edit, :update, :destroy]

  def index
    @activities = current_user.activities
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user

    if @activity.save
      redirect_to activities_path, flash: { success: "Activity was added." }
    else
      flash.now[:error] = "There was an error creating the activity. #{@activity.errors.full_messages.to_sentence}."
      @activities = current_user.activities
      render "index"
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      flash[:success] = "Activity was updated."
      redirect_to activities_path
    else
      flash.now[:error] = "There was an error updating the activity. #{@activity.errors.full_messages.to_sentence}."
      render "edit"
    end
  end

  def destroy
    if
      @activity.soft_delete
      redirect_to activities_path
    else
      flash.now[:error] = "There was an error deleting the activity."
      redirect_to activities_path
    end
  end


  private
    def activity_params
      params.require(:activity).permit(:name)
    end

    def load_user_activity
      @activity = current_user.activities.find(params[:id])
    end
end
