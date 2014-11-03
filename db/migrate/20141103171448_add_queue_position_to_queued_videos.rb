class AddQueuePositionToQueuedVideos < ActiveRecord::Migration
  def change
    add_column :queued_videos, :queue_position, :integer
  end
end
