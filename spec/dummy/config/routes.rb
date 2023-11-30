Rails.application.routes.draw do
  mount WasteCarriersEngine::Engine => "/", as: "basic_app_engine"

  devise_for :users
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "waste_carriers_engine/registrations#index"

  resources :registrations,
            only: :show,
            param: :reg_identifier,
            path: "/bo/registrations"
end
