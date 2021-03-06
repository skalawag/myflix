class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    User.all.each do |user|
      user.token = SecureRandom.urlsafe_base64
    end
  end
end
