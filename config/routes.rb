Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  concern :api_base do
    get 'ping' => 'table_tennis#ping'
    resources :postits, only: [:show, :index, :create, :update, :destroy]
    resources :users, only: [:show]
  end

  namespace :v1 do
    concerns :api_base
  end

  namespace :v2 do
    concerns :api_base
  end
end
