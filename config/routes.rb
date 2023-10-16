Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'pages#index'

  get '/survey', to: 'pages#survey'
  get 'leaderboard', to: 'pages#leaderboard'
  get 'project', to: 'pages#project'
end
