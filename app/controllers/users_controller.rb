class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.save
      redirect_to home_path # with welcome
    else
      @user.save
      render :new
    end
  end

  def queue
    @queued_videos = current_user.videos.order('queue_position')
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
