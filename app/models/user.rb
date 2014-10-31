class User < ActiveRecord::Base
  validates_presence_of :email, :username, :password
  validates_uniqueness_of :email
  has_secure_password validations: false
  has_many :reviews

  has_many :queued_videos
  has_many :videos, through: :queued_videos
end
