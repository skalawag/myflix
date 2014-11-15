class ChangeColumnNameInFollowerRelations < ActiveRecord::Migration
  def change
    rename_column :follower_relations, :followed_id, :followee_id
  end
end
