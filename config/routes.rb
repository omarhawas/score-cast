Rails.application.routes.draw do
  resources :tournament_predictions
  
  root "tournaments#index"

  resources :tournaments do
    resources :leagues 
    resources :games
    resources :tournament_predictions
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
    resources :tournament_predictions
  end

  resources :games do
    resources :game_predictions 
  end

  resource :session, only: [:new, :create, :destroy]
end