class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def sort_queued_items(items)
    position_counter = 1
    items.each do |item|
      queued_video = QueuedVideo.where(user_id: current_user.id,
                                       video_id: item["id"])
      queued_video.first.update(queue_position: position_counter)
      position_counter += 1
  end
end
