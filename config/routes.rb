Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  resources :users, only: [:index]
  resources :surveys, only: %i[new create show index]
  get 'leaderboard', to: 'users#index'
  get 'project', to: 'pages#project'
  get 'account', to: 'users#show'
  get 'search_date', to: 'pages#search_date'
end
