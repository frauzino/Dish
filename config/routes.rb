Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  resources :users, only: [:index]
  resources :surveys, only: %i[new create show index]
  get 'leaderboard', to: 'users#index'
  get 'project', to: 'pages#project'
  get 'account', to: 'users#show'
  get 'search_date', to: 'users#search_date'
  get 'users/update_access', to: 'users#update_access'
end
