Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  get 'profiles/:id/friends', to: 'profiles#friends'

  resources :profiles, except: :destroy

  resources :likes, only: [:index, :create, :destroy]


  resources :friendship_requests, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
