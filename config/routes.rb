Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'

  # synonym for videos
  get '/home', to: 'videos#index'

  resource :videos, only: [:index]
  # this is a category route
  get '/genre/:genre', to: 'videos#genre', as: :genre
  # show a particular video
  get '/video/:id', to: 'videos#show', as: :show
  post '/video/:id', to: 'reviews#create', as: :new_review

  # special route
  get '/search', to: 'videos#search_by_title', as: :search

  # new users
  get '/registration', to: 'users#new', as: :registration
  post '/registration', to: 'users#create', as: :register

  # sessions
  resources :session, only: [:new, :create], as: :login
  get '/logout', to: 'session#destroy'
end
