Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'

  # synonym for videos
  get '/home', to: 'videos#index'

  resources :videos, only: [:index]
  namespace :admin do
    resources :videos, only: [:new]
  end

  # this is a category route
  # maybe this should be: get '/category/:id', to: 'videos#genre', as: category
  get '/genre/:genre', to: 'videos#genre', as: :genre

  # show a particular video (include under resourceful route above)
  get '/video/:id', to: 'videos#show', as: :show

  # post to reviews
  # why not: resources :review, only: :create, as: :new_review
  post '/video/:id', to: 'reviews#create', as: :new_review

  # special route
  get '/search', to: 'videos#search_by_title', as: :search

  # new users
  # get '/registration', to: 'users#new', as: :registration
  # post '/registration', to: 'users#create', as: :register
  ## FIXME: this is going to break some links on the start page
  resources :users, only: [:new, :create, :show] do
    resources :people, to: 'follower_relations', only: [:index, :destroy, :new]
  end

  get 'queue', to: 'queues#queue'
  get '/add_to_queue/:id', to: 'queues#add_to_queue'
  post '/remove_from_queue/:id', to: 'queues#remove_from_queue'
  post 'update_queue', to: 'queues#update_queue'

  # sessions
  resource :session, only: [:new, :create], as: :login
  get '/logout', to: 'sessions#destroy'

  get 'reset_password', to: 'reset_password#new'
  get 'reset_password_confirmation', to: 'reset_password#confirm'

  resources :reset_password, only: [:create]
  resources :new_password, only: [:show, :create]
  resources :invitations, only: [:new, :create, :show]

end
