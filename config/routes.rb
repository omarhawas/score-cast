Rails.application.routes.draw do
  
  root "tournaments#index"

  resources :tournaments do
    resources :leagues, only: [:index, :show, :new, :create] # Nested routes for leagues under tournaments
    resources :games, only: [:index, :show, :new, :create]    # Nested routes for games under tournaments
  end

  resources :leagues, only: [:show, :edit, :update, :destroy] do
    resources :league_users, only: [:index, :show, :new, :create] # Nested routes for league_users under leagues
  end

  resources :users do
    resources :league_users, only: [:index, :show, :new, :create] # Nested routes for league_users under users
  end
  get "signup" => "users#new"

  resources :league_users, only: [:show, :edit, :update, :destroy] do
    resources :game_predictions, only: [:index, :show, :new, :create] # Nested routes for game_predictions under league_users
  end

  resources :games, only: [:show, :edit, :update, :destroy] do
    resources :game_predictions, only: [:index, :show, :new, :create] # Nested routes for game_predictions under games
  end

  resources :game_predictions, only: [:edit, :update, :destroy] # GamePredictions are nested under both league_users and games

  resource :session, only: [:new, :create, :destroy]
end