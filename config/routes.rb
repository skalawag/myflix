Myflix::Application.routes.draw do
  root to: 'ui#index'
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  resources :videos
end
