class FollowerRelationsController < ApplicationController
  def index
    @followees = User.find(params[:user_id]).followees
  end

  def destroy
    current_user.followees.delete(User.find(params[:id]))
    redirect_to user_people_path(current_user)
  end
end
