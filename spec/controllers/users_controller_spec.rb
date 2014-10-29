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
      post :create, user: { username: "Joe Small",
                            email: "whatever@mail.com",
                            password: "hello"
                          }
      assigns(:user).should eq(User.first)
    end

    it "should report 'can't be blank' without password" do
      post :create, user: { username: "Joe Small",
                            email: "whatever@mail.com"
                          }
      assigns(:user).errors.messages[:password].first.should eq("can't be blank")
    end

    it "should report 'can't be blank' without username" do
      post :create, user: { password: "JoeSmall",
                            email: "whatever@mail.com"
                          }
      assigns(:user).errors.messages[:username].first.should eq("can't be blank")
    end

    it "should report 'can't be blank' without email" do
      post :create, user: { password: "JoeSmall",
                            username: "Joe Small"
                          }
      assigns(:user).errors.messages[:email].first.should eq("can't be blank")
    end

    it "renders index.html if user is valid and can be saved" do
      post :create, user: { username: "Joe Small",
                            email: "whatever@mail.com",
                            password: "hello"
                          }
      response.should redirect_to home_path
    end

    it "should render :new without password" do
      post :create, user: { username: "Joe Small",
                            email: "whatever@mail.com"
                          }
      response.should render_template :new
    end

    it "should render new without username" do
      post :create, user: { password: "JoeSmall",
                            email: "whatever@mail.com"
                          }
      response.should render_template :new
    end

    it "render new without email" do
      post :create, user: { password: "JoeSmall",
                            username: "Joe Small"
                          }
      response.should render_template :new
    end
  end
end
