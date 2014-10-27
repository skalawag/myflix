Myflix::Application.routes.draw do
  root to: 'ui#index'
  get 'ui(/:action)', controller: 'ui'

  resources :videos

  # synonym for videos
  get '/home', to: 'videos#index'
  # this is like show:
  get '/video', to: 'videos#video'

  # this is a category route
  get '/genre/:genre', to: 'videos#genre', as: :genre

  # special route
  get '/search', to: 'videos#search_by_title', as: :search

end
