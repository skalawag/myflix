require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "renders the new invitation page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET show" do
    it "has a new user set to @user" do
      get :show, id: "asdf"
      expect(assigns(:user)).to be_a(User)
    end

    it "has an invitation if one exists" do
      invite = Fabricate(:invitation)
      get :show, id: invite.token
      expect(assigns(:invitation)).to be_a(Invitation)
    end

    it "renders show template" do
      invite = Fabricate(:invitation)
      get :show, id: invite.token
      expect(response).to render_template :show
    end

    it "redirects to new_user_path if there is no invitation" do
      get :show, id: "asdfj"
      expect(response).to redirect_to new_user_path
    end
  end

  context "with email" do
    after { ActionMailer::Base.deliveries.clear }

    describe "POST create" do
      it "invitation to be valid" do
        user = authenticated_user
        post :create, name: "Mark Scala", email: "markscala@gmail.com", message: "Hey, join up."
        invite = Invitation.first
        expect(invite).to be_a(Invitation)
      end

      it "sets flash success if successful" do
        user = authenticated_user
        post :create, name: "Mark Scala", email: "markscala@gmail.com", message: "Hey, join up."
        expect(flash[:success]).to eq("Your invitation has been sent.")
      end

      it "redirects to home path after successful invitation made" do
        user = authenticated_user
        post :create, name: "Mark Scala", email: "markscala@gmail.com", message: "Hey, join up."
        expect(response).to redirect_to home_path
      end

      it "sets flash error if unsuccessful because email fails" do
        user = authenticated_user
        post :create, name: "Mark Scala", email: "", message: "Hey, join up."
        expect(flash[:error]).to eq("Something was wrong with your invitation.")
      end

      it "sets flash error if unsuccessful because name is missing" do
        user = authenticated_user
        post :create, name: "", email: "markscala@gmail.com", message: "Hey, join up."
        expect(flash[:error]).to eq("Something was wrong with your invitation.")
      end

      it "renders new if unsuccessful" do
        user = authenticated_user
        post :create, name: "", email: "markscala@gmail.com", message: "Hey, join up."
        expect(response).to render_template :new
      end
    end
  end
end
