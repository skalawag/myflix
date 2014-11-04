class QueuesController < ApplicationController
  def queue
    @queued_videos = current_user.videos.order('queue_position')
  end

  def update_queue
    queue_items = params[:queue_items].sort { |i,j| i['position'] <=> j['position'] }
    sort_queued_items(queue_items)
    redirect_to queue_path
  end

  def add_to_queue
    video = Video.find_by id: params[:id]
    QueuedVideo.create(user_id: current_user.id, video_id: video.id, queue_position: current_user.videos.count + 1)
    redirect_to queue_path
  end

  def remove_from_queue
    video = Video.find_by id: params[:id]
    current_user.videos.delete(video)
    redirect_to queue_path
  end
end
