Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'}
  root "pages#home"
  # Defines the root path route ("/")
  get "desks/load_more", to: "desks#load_more", as: :load_more_desks
  resources :desks do
    # collection do
    #   get :load_more
    # end
    resources :messages, only: [:new, :create]
    resource :follows, only: [:create, :destroy]
  end
  resources :rooms do
    post "invite/:user_id", to: "invites#create", as: :invite
    resources :chatmessages, only: :create
    resources :polls, only: [:create, :edit, :update] do
      resources :ballots, only: :create
    end
  end
  get "/my_rooms", to: "rooms#my_rooms"

  resources :spots
  resources :votes, only: [:create] do
    delete "/", to: "votes#destroy", on: :collection
  end

  post "/update_user_last_online", to: "application#update_user_last_online"
  get "/followed_users_status", to: "application#followed_users_status"
end
