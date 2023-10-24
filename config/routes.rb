Rails.application.routes.draw do
  devise_for :users
  # mount Rapidfire::Engine => "/rapidfire"

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'

  resources :surveys, only: %i[new create]
  get 'leaderboard', to: 'pages#leaderboard'
  get 'project', to: 'pages#project'
  get 'account', to: 'pages#account'
end
