Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'

  resources :videos

  # synonym for videos
  get '/home', to: 'videos#index'
  # this is like show:
  get '/video', to: 'videos#show'

  # this is a category route
  get '/genre/:genre', to: 'videos#genre', as: :genre

  # special route
  get '/search', to: 'videos#search_by_title', as: :search

  # new users
  get '/registration', to: 'users#new', as: :registration
  post '/registration', to: 'users#create', as: :register

  # sessions
  resources :session, only: [:new, :create], as: :login
  get '/logout', to: 'session#destroy'
end
