class QueuesController < ApplicationController
  def queue
    @queued_videos = current_user.videos.order('queue_position')
  end
end
