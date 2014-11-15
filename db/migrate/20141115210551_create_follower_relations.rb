class CreateFollowerRelations < ActiveRecord::Migration
  def change
    create_table :follower_relations do |t|
      t.timestamps
      t.integer :user_id
      t.integer :followed_id
    end
  end
end
