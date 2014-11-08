require 'spec_helper'

describe QueuedVideo do
  it { should belong_to :user }
  it { should belong_to :video }
  it { should validate_numericality_of :queue_position }

  context "with user and video" do
    before do
      Fabricate(:video)
      Fabricate(:user)
    end

    let(:user) { User.first }
    let(:video) { Video.first }

    it "should reject decimal queue_positions" do
      qv = QueuedVideo.create(user_id: user.id,
                              video_id: video.id,
                              queue_position: 1.4)
      expect(qv.id).to eq(nil)
    end

    it "should reject queue_positions that are less than 1" do
      qv = QueuedVideo.create(user_id: user.id,
                              video_id: video.id,
                              queue_position: 0)
      expect(qv.id).to eq(nil)
    end
  end
end
