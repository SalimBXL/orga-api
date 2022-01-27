Rails.application.routes.draw do
  get 'ping' => 'application#ping'

  resources :postits, only: :show
end
