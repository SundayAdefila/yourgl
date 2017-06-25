Rails.application.routes.draw do
  resources :contents, except: [:new, :edit, :update]
end
