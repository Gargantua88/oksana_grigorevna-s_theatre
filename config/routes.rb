Rails.application.routes.draw do
  resources :perfomances, only: [:index, :create, :destroy]
end
