Rails.application.routes.draw do
  
  get '/auth/facebook/callback' => 'sessions#facebook'
  get 'auth/failure', to: redirect('/')
  
  root 'sessions#welcome'

  get '/home' => 'sessions#home'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#login'

  get '/logout' => 'sessions#logout'
   
  resources :users
    
  resources :locations do
    resources :tasks
  end

  resources :locations do
    delete :destroy
  end
  
  resources :tasks
    get '/404', :to => 'errors#not_found'
  end
