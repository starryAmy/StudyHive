Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'}

  root "pages#home"
  # Defines the root path route ("/")
  resources :desks do
    resources :messages, only: [:new, :create]
  end
  resources :rooms do
    resources :spots
  end

end
