Rails.application.routes.draw do
  devise_for :users
  # mount Rapidfire::Engine => "/rapidfire"

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'

  get 'survey', to: 'pages#survey'
  get 'leaderboard', to: 'pages#leaderboard'
  get 'project', to: 'pages#project'
  get 'account', to: 'pages#account'
end
