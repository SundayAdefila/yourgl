Rails.application.routes.draw do
  resources :contents, only: [:create, :index]
end
