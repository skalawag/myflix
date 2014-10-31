class CreateQueuedVideos < ActiveRecord::Migration
  def change
    create_table :queued_videos do |t|
      t.integer :user_id
      t.integer :video_id
      t.timestamps
    end
  end
end
