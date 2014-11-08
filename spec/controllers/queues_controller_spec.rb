require 'spec_helper'

describe QueuesController do

  describe "GET add_to_queue" do
    let(:result) { Fabricate(:video, title: "Family Guy") }

    before { authenticated_user }

    it "adds result to user's queue" do
      get :add_to_queue, id: result.id
      expect(User.first.videos.first).to eq(result)
    end

    it "removes video from user's queue" do
      QueuedVideo.create(user_id: session[:user_id],
                         video_id: result.id,
                         queue_position: 1)
      post :remove_from_queue, id: Video.first.id
      expect(User.first.videos).to eq([])
    end
  end

  describe "GET queue" do

    before { authenticated_user }
    let(:user) { User.first }

    it "sets @queued_videos to [] if user has no videos in queue" do
      get :queue, id: user.id
      expect(assigns(:queued_videos)).to eq([])
    end

    it "sets @queued_videos to array of users queued videos if they exist" do
      create_queue
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

  describe "POST update_queue" do

    before { authenticated_user && create_queue }

    # video 1 is in queue_position 1, etc.
    it "test setup is correct" do
      expect(QueuedVideo.all.map(&:'video_id')).to eq(Video.all.map(&:id))
    end

    it "fixes defective value 1.5 validation" do
      post_to_queue(2, 1, 1.5)
      expect(video_ids_by_queue_position.second).to eq(3)
    end

    it "swaps two items on the queue, where the user explicitly numbers them" do
      post_to_queue(2, 1, 3)
      expect(video_ids_by_queue_position).to  eq([2,1,3])
    end

    it "moves an item to the end if user renumbers it largest" do
      post_to_queue(4, 2, 3)
      expect(video_ids_by_queue_position).to  eq([2,3,1])
    end

    it "sorts out duplicate numbers in a default way" do
      post_to_queue(3, 2, 3)
      expect(video_ids_by_queue_position).to  eq([2, 1, 3])
    end
  end
end
