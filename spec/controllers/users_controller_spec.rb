require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user instance variable" do
      get :new
      assigns(:user).should be_an(User)
    end
  end

  describe "POST create" do
    it "sets @user to a new user" do
      post_create_new_user("Joe Small", "whatever@mail.com", "hello")
      assigns(:user).should eq(User.first)
    end

    it "should report 'can't be blank' without password" do
      post_create_new_user("Joe Small", "whatever@mail.com")
      assigns(:user).errors.messages[:password].first.should eq("can't be blank")
    end

    it "should report 'can't be blank' without username" do
      post_create_new_user(nil, "whatever@mail.com", "password")
      assigns(:user).errors.messages[:username].first.should eq("can't be blank")
    end

    it "should report 'can't be blank' without email" do
      post_create_new_user("Joe Small", nil, "password")
      assigns(:user).errors.messages[:email].first.should eq("can't be blank")
    end

    it "renders index.html if user is valid and can be saved" do
      post_create_new_user("Joe Small", "whatever@gmail.com", "hello")
      response.should redirect_to home_path
    end

    it "should render :new without password" do
      post_create_new_user("Joe Small", "whatever@gmail.com")
      response.should render_template :new
    end

    it "should render new without username" do
      post_create_new_user(nil, "whatever@gmail.com", "password")
      response.should render_template :new
    end

    it "render new without email" do
      post_create_new_user("Joe Small", nil, "password")
      response.should render_template :new
    end
  end
end
