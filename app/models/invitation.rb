class Invitation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :new_user_email, :new_user_name, :token, :user_id
end
