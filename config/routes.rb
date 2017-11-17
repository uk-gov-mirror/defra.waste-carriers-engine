Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  resources :registrations

  get "/pages/:page" => "pages#show"

  root "registrations#index"
end
