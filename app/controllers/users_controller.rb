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

  def update_queue
    queue_items = params[:queue_items].sort { |i,j| i['position'] <=> j['position'] }
    position_counter = 1
    queue_items.each do |item|
      queued_video = QueuedVideo.where(user_id: current_user.id,
                                       video_id: item["id"])
      queued_video.first.update(queue_position: position_counter)
      position_counter += 1
    end
    redirect_to queue_user_path(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
