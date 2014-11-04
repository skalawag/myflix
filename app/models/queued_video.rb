class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def self.renumber_queued_items(items, uid)
    position_counter = 1
    items.each do |item|
      queued_video = QueuedVideo.where(user_id: uid,
                                       video_id: item["id"])
      queued_video.first.update(queue_position: position_counter)
      position_counter += 1
    end
  end
end
