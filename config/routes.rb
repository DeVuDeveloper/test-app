Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "ovens#index", as: :store_root
  end

  root to: "visitors#index"

  resources :ovens do
    resources :cookies, only: [:new, :create]
    member do
      post :empty
      get :oven_status
      patch :toggle_status
    end
  end

  resources :orders, only: [:index]

  namespace :api do
    resources :orders, only: [:index] do
      patch :fulfill, on: :member
    end
  end
end
