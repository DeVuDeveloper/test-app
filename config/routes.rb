Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :update] do
    patch "add_balance", on: :member
  end

  authenticated :user do
    root to: "ovens#index", as: :store_root
  end

  root to: "visitors#index"

  resources :ovens do
    resources :cookies, only: [:create] do
      post :claim_change, on: :collection
    end

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
