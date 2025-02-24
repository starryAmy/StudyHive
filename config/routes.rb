Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'}

  root "pages#home"
  # Defines the root path route ("/")
  resources :desks do
    resources :messages, only: [:new, :create]
    resource :follows, only: [:create, :destroy]
  end
  resources :rooms do

    resources :chatmessages, only: :create
  end

  resources :spots
  resources :votes, only: [:create, :destroy]

end
