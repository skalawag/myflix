require 'spec_helper'

describe QueuesController do
  describe "GET add_to_queue" do
    let(:result) { Fabricate(:video, title: "Family Guy") }

    context "with authenticated user" do
      before do
        Fabricate(:user)
        session[:user_id] = 1
      end

      it "adds result to user's queue" do
        get :add_to_queue, id: result.id
        expect(User.first.videos.first).to eq(result)
      end

      it "removes video from user's queue" do
        User.first.videos << result
        post :remove_from_queue, id: Video.first.id
        expect(User.first.videos).to eq([])
      end
    end
  end

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

      # video 1 is in queue_position 1, etc.
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
        # queue_position order, so when they are reordered, there is a
        # tie between 1,3. but since the sorter comes across 1 before
        # it comes across 3, 1 is renumbered first.
        expect(QueuedVideo.where(user_id: session[:user_id]).order('queue_position').map(&:video_id)).to  eq([2, 1, 3])
      end
    end
  end
end
