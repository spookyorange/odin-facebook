Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts, except: :destroy do
    resources :comments
  end

  resources :profiles
  resources :likes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
