Myflix::Application.routes.draw do
  root to: 'ui#index'
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  get '/video', to: 'videos#video'
  get '/genre/:genre', to: 'videos#genre', as: :genre
  get '/search', to: 'video#search_by_title', as: :search

end
