Rails.application.routes.draw do
  
  root "tournaments#index"

  resources :tournaments do
    resources :leagues 
    resources :games    
  end

  resources :leagues do
    resources :league_users
  end

  resources :users do
    resources :league_users
  end
  
  get "signup" => "users#new"

  resources :league_users do
    resources :game_predictions 
  end

  resources :games do
    resources :game_predictions 
  end

  resource :session, only: [:new, :create, :destroy]
end