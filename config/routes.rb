Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:index]
  resources :surveys, only: %i[new create]
  get 'leaderboard', to: 'users#index'
  get 'project', to: 'pages#project'
  get 'account', to: 'users#show'
end
