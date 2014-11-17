class ChangeUserTokensToNil < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.token = nil
    end
  end
end
