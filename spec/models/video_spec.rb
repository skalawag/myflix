require 'spec_helper'

describe Video do
  it { should have_many :video_categories }
  it { should have_many :categories }
end
