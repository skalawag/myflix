require 'spec_helper'

describe UsersController do
  describe "GET show", {vcr: true} do
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

    after { ActionMailer::Base.deliveries.clear }

    context "with invalid personal info"

    context "with valid personal info and declined card" do
      before do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.stub(:create).and_return(charge)
      end

      it "doesn't create a new user record" do
        post :create, user: Fabricate.attributes_for(:user), stripe_token: '1234'
        expect(User.count).to eq(0)
      end

      it "renders the new action" do
        post :create, user: Fabricate.attributes_for(:user), stripe_token: '1234'
        expect(response).to render_template :new
      end

      it "sets the flash error" do
        post :create, user: Fabricate.attributes_for(:user), stripe_token: '1234'
        expect(flash[:error]).to be_present
      end
    end

    context "with valid personal info" do
      before do
        charge = double(:create, successful?: true)
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post_create_new_user("Joe Small", "whatever@whatever.com", "hellogeorge")
      end

      let(:msg) { ActionMailer::Base.deliveries.first }

      it "sends an email to new user" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends to the correct recipient" do
        expect(msg.to).to eq(["whatever@whatever.com"])
      end

      it "should have subject 'Welcome!'" do
        expect(msg.subject).to eq("Welcome!")
      end

      it "should use the user's name in the body" do
        expect(msg.body).to include("Joe Small")
      end

      it "should use the user's name in the body" do
        expect(msg.body).to include("Welcome to Myflix! Enjoy the service.")
      end

      it "sets flash success message" do
        expect(flash[:success]).to eq("Thank you for choosing Myflix. Please sign in!")
      end

      it "sets @user to a new user" do
        expect(assigns(:user)).to eq(User.first)
      end

      it "renders index.html if user is valid and can be saved" do
        expect(response).to redirect_to new_login_path
      end
    end

    context "with missing pieces of personal info" do
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
    end

    context "with stripewrapper stub" do
      before do
        charge = double(:create, successful?: true)
        StripeWrapper::Charge.stub(:create).and_return(charge)
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
end
