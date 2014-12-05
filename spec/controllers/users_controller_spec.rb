require 'spec_helper'

describe UsersController do
  describe "GET show" do
    it "sets @user variable" do
      user = authenticated_user
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it "should render show.html" do
      user = authenticated_user
      get :show, id: 1
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    it "sets @user instance variable" do
      get :new
      assigns(:user).should be_an(User)
    end
  end

  describe "POST create" do
    before { StripeWrapper::Charge.stub(:create) }
    context "email sending" do
      after { ActionMailer::Base.deliveries.clear }
      it "sends an email to new user" do
        post :create, user: {username: "Joe Small",
                             email: "whatever@whatever.com",
                             password: "hellogeorge"}
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends to the correct recipient" do
        post :create, user: {username: "Joe Small",
                             email: "whatever@whatever.com",
                             password: "hellogeorge"}
        msg = ActionMailer::Base.deliveries.first
        expect(msg.to).to eq(["whatever@whatever.com"])
      end

      it "should have subject 'Welcome!'" do
        post :create, user: {username: "Joe Small",
                             email: "whatever@whatever.com",
                             password: "hellogeorge"}
        msg = ActionMailer::Base.deliveries.first
        expect(msg.subject).to eq("Welcome!")
      end

      it "should use the user's name in the body" do
        post :create, user: {username: "Joe Small",
                             email: "whatever@whatever.com",
                             password: "hellogeorge"}
        msg = ActionMailer::Base.deliveries.first
        expect(msg.body).to include("Joe Small")
      end

      it "should use the user's name in the body" do
        post :create, user: {username: "Joe Small",
                             email: "whatever@whatever.com",
                             password: "hellogeorge"}
        msg = ActionMailer::Base.deliveries.first
        expect(msg.body).to include("Welcome to Myflix! Enjoy the service.")
      end
    end

    it "sets @user to a new user" do
      post :create, user: {username: "Joe Small",
                           email: "whatever@whatever.com",
                           password: "hellogeorge"}
      expect(assigns(:user)).to eq(User.first)
    end

    it "should report 'can't be blank' without password" do
      post_create_new_user("Joe Small", "whatever@mail.com")
      expect(assigns(:user).errors.messages[:password].first).to eq("can't be blank")
    end

    it "should report 'can't be blank' without username" do
      post_create_new_user(nil, "whatever@mail.com", "password")
      expect(assigns(:user).errors.messages[:username].first).to eq("can't be blank")
    end

    it "should report 'can't be blank' without email" do
      post_create_new_user("Joe Small", nil, "password")
      expect(assigns(:user).errors.messages[:email].first).to eq("can't be blank")
    end

    it "renders index.html if user is valid and can be saved" do
      post_create_new_user("Joe Small", "whatever@gmail.com", "hellogeorge")
      expect(response).to redirect_to home_path
    end

    it "should render :new without password" do
      post_create_new_user("Joe Small", "whatever@gmail.com")
      expect(response).to render_template :new
    end

    it "should render new without username" do
      post_create_new_user(nil, "whatever@gmail.com", "password")
      expect(response).to render_template :new
    end

    it "render new without email" do
      post_create_new_user("Joe Small", nil, "password")
      expect(response).to render_template :new
    end

    it "inviter should be following new user" do
      user1 = Fabricate(:user)
      user2 = User.new(username: "Bilbo", email: "bilbo@bilbo.com", password: "asdfasdf")
      Invitation.create(new_user_email: user2.email, new_user_name: user2.username, token: "asdf", user_id: user1.id)
      post :create, user: {username: user2.username,
                           email: user2.email,
                           password: user2.password}
      expect(user1.followees).to include(User.second)
    end


    it "new user should be following inviter" do
      user1 = Fabricate(:user)
      user2 = User.new(username: "Bilbo", email: "bilbo@bilbo.com", password: "asdfasdf")
      Invitation.create(new_user_email: user2.email, new_user_name: user2.username, token: "asdf", user_id: user1.id)
      post :create, user: {username: user2.username,
                           email: user2.email,
                           password: user2.password}
      expect(User.second.followees).to include(user1)
    end
  end
end
