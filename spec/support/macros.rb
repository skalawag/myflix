# For queue_controller
def authenticated_user
  Fabricate(:user)
  session[:user_id] = 1
end

def create_queue
  3.times do |n|
    video = Fabricate(:video)
    QueuedVideo.create(user_id: session[:user_id],
                       video_id: video.id,
                       queue_position: n+1)
  end
end

def post_to_queue(*items)
  post :update_queue,
       queue_items: [{"id" => "1", "position" => items[0].to_s},
                     {"id" => "2", "position" => items[1].to_s},
                     {"id" => "3", "position" => items[2].to_s}],
       ratings: []
end

def video_ids_by_queue_position
  QueuedVideo.where(user_id: session[:user_id]).order('queue_position').map(&:video_id)
end


# For users_controller
def test_user
  Fabricate(:user, username: "test_user", email: "test_email", password: "test")
end

def post_create_new_user(username=nil, email=nil, password=nil)
  post :create, user: { username: username,
                        email: email,
                        password: password
                      }
end

# for category spec

def new_category
  Category.create(name: "Test")
end

def categorize_m_videos(m)
  m.times do |n|
    Category.first.videos << Video.create(title: "#{n}", description: "#{n} description", created_at: n.days.ago)
  end
end

# For Feature Specs

def sign_in_user
  user = Fabricate(:user)
  visit new_login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Submit"
end
