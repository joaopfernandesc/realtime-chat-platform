Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  resources :messages, only: [:index, :create]
end
