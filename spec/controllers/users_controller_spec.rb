require 'spec_helper'

describe UsersController do
  describe "GET queue" do
    context "with existing user" do
      before do
        Fabricate(:user)
        session[:user_id] = User.first.id
      end

      let(:user) { User.first }

      it "sets @queued_videos to [] if user has no videos in queue" do
        get :queue, id: user.id
        expect(assigns(:queued_videos)).to eq([])
      end

      it "sets @queued_videos to array of users queued videos if they exist" do
        3.times do
          user.videos << Fabricate(:video)
        end
        get :queue, id: user.id
        expect(assigns(:queued_videos).to_a).to eq(Video.all)
      end

      it "sets @queued_videos according to queue_position order" do
        3.times do |n|
          QueuedVideo.create(user_id: n+1, video_id: n+1, queue_position: 3-n)
        end
        get :queue, id: user.id
        expect(assigns(:queued_videos)).to eq(Video.all.reverse)
      end
    end
  end

  describe "POST update_queue" do
    context "with existing user and queue" do
      before do
        Fabricate(:user)
        session[:user_id] = User.first.id
        3.times do |n|
          video = Fabricate(:video)
          QueuedVideo.create(user_id: session[:user_id],
                             video_id: video.id,
                             queue_position: n+1)
        end
      end

      it "test setup is correct" do
        expect(QueuedVideo.all.map(&:'video_id')).to eq(Video.all.map(&:id))
      end

      it "swaps two items on the queue, where the user explicitly numbers them" do
        post :update_queue, queue_items: [{"id" => "1", "position" => "2"},
                                          {"id" => "2", "position" => "1"},
                                          {"id" => "3", "position" => "3"}]
        # the video_id's ordered by queue_position are 2, 1, 3
        expect(QueuedVideo.where(user_id: session[:user_id]).order('queue_position').map(&:video_id)).to  eq([2,1,3])
      end

      it "moves an item to the end if user renumbers it largest" do
        post :update_queue, queue_items: [{"id" => "1", "position" => "4"},
                                          {"id" => "2", "position" => "2"},
                                          {"id" => "3", "position" => "3"}]
        # the video_id's ordered by queue_position are 2, 3, 1
        expect(QueuedVideo.where(user_id: session[:user_id]).order('queue_position').map(&:video_id)).to  eq([2,3,1])
      end

      it "sorts out duplicate numbers in a default way" do
        post :update_queue, queue_items: [{"id" => "1", "position" => "3"},
                                          {"id" => "2", "position" => "2"},
                                          {"id" => "3", "position" => "3"}]
        # the video_id's ordered by queue_position are 2, 1, 3 (the
        # videos are passed to the sorter in their original
        # order. when they are reordered, there is a tie between 1,3,
        # but since we come across 1 before 3, it is renumbered first.
        expect(QueuedVideo.where(user_id: session[:user_id]).order('queue_position').map(&:video_id)).to  eq([2, 1, 3])
      end
    end
  end

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
