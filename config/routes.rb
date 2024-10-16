Rails.application.routes.draw do
  get 'rooms/index'
  get 'users/show_account', to: 'users#show_account'
  get 'users/show_profile', to: 'users#show_profile'
  get 'users/edit_profile', to: 'users#edit_profile'
  patch 'users/edit_profile', to: 'users#update_profile'
  root 'home#index'
  get 'home/show'
  get 'rooms/own', to: 'rooms#own'
  devise_for :users
  get "users" => redirect("/users/sign_up")
  resources :rooms do
    resources :reservations, only: [:new, :create, :index]
  end
  resources :reservations do
    post 'confirm', to: 'reservations#confirm', on: :collection
    post 'edit_confirm', to: 'reservations#edit_confirm', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
