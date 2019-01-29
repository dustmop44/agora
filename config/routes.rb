Rails.application.routes.draw do
  
  get 'sessions/new'

  get '/signup', to:'users#new'

  get '/contact', to:'static_pages#contact'
  
  get '/help', to: 'static_pages#help'
  
  get '/about', to: 'static_pages#about'
  
  get '/news', to: 'static_pages#news'
  
  post '/signup', to:'users#create'
  
  get '/login', to:'sessions#new'
  
  post '/login', to:'sessions#create'
  
  delete '/logout', to:'sessions#destroy'
  
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
