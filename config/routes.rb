Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get 'ping' => 'table_tennis#ping'

  resources :postits, only: [:show, :index, :create, :update, :destroy]
  resources :users, only: [:show]
end
