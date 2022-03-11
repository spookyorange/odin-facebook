Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :profiles, except: :destroy do
    resources :comments
  end

  resources :posts
  resources :likes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
