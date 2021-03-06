Rails.application.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  root to: "root#index"

  # omniauth
  get "/auth/:provider/callback", to: "sessions#create"

  delete "/signout" => "sessions#destroy", as: :signout

  resources :incenses, only: [:create, :index], concerns: :paginatable

  get "/@:nickname/(page/:page)" => "users#show", as: :user
  post "token" => "users#create_token", as: :token

  resource :documents, only: :show

  # API
   mount YmsrAPI => "/api"
end
