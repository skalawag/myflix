class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_numericality_of :queue_position, only_integer: true, greater_than: 0

  def self.renumber_queued_items(items, uid)
    position_counter = 1
    ActiveRecord::Base.transaction do
      items.each do |item|
        queued_video = QueuedVideo.where(user_id: uid,
                                         video_id: item["id"])
        queued_video.first.update(queue_position: position_counter)
        position_counter += 1
      end
    end
  end
end
