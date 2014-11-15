require 'spec_helper'

describe FollowerRelationsController do

  context "with authenticated user" do
    before do
      authenticated_user
    end

    describe "GET index" do
      it "should set @followees variable to [] if user follows nobody" do
        get :index, user_id: User.first.id
        expect(assigns(:followees)).to eq([])
      end

      it "should set @followees to a user if user follows exactly 1 person" do
        user = User.first
        user.followees << Fabricate(:user)
        get :index, user_id: user.id
        expect(assigns(:followees)).to eq([User.second])
      end

      it "should render index" do
        get :index, user_id: User.first.id
        expect(response).to render_template :index
      end
    end

    describe "DELETE destroy" do
      it "should remove followee with params[:id] from current_user followees" do
        User.first.followees << Fabricate(:user)
        delete :destroy, user_id: 1, id: 2
        expect(User.first.followees).to eq([])
      end
      it "should redirect_to users_people_path" do
        User.first.followees << Fabricate(:user)
        delete :destroy, user_id: 1, id: 2
        expect(response).to redirect_to user_people_path(User.first)
      end
    end
  end
end
