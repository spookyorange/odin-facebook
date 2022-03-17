Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  get 'profiles/:id/friends', to: 'profiles#friends'
  get 'profiles/:id/liked_posts', to: 'profiles#liked_posts', as: :liked_posts
  get 'posts/:id/liked_by', to: 'posts#liked_by', as: :liked_by

  resources :profiles, except: :destroy

  resources :likes, only: [:create, :destroy]


  resources :friendship_requests, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
