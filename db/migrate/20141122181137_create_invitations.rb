class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.timestamps
      t.integer :user_id
      t.string :token
      t.string :new_user_email
      t.string :new_user_name
    end
  end
end
