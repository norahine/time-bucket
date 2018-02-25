class EntriesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @activities = current_user.activities
    @entry = Entry.new
  end

  def create


  end

  def edit
  end

  def update
  end

  def destroy
  end
end
