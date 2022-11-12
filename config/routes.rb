Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  namespace :api do
    namespace :v1 do
      resources :users, only:  [:index, :show] do
        resources :posts, only:  [:index] do
          resources :comments, only:  [:index, :create]
        end
      end
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end
end
