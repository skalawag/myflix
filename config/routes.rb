Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'

  # synonym for videos
  get '/home', to: 'videos#index'

  resources :videos, only: [:index] do
    member do
      get :add_to_queue
    end
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
  resources :users, only: [:new, :create] do
    member do
      get :queue
    end
  end

  # sessions
  resource :session, only: [:new, :create], as: :login
  get '/logout', to: 'session#destroy'
  # ## Can I do this?
  # resource :session, only: [:new, :create], as: :login do
  #   member do
  #     get :logout, to: 'session#destroy', as: :logout
  #   end
  # end
end
