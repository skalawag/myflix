class Invitation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :new_user_email, :new_user_name, :token, :user_id
  validates_format_of :new_user_email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/, on: :create
end
