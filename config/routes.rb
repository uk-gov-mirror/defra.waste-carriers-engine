Rails.application.routes.draw do
  devise_for :users
  resources :registrations
end
