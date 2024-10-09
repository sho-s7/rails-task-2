Rails.application.routes.draw do
  get 'users/show_account', to: 'users#show_account'
  get 'users/show_profile', to: 'users#show_profile'
  get 'users/edit_profile', to: 'users#edit_profile'
  patch 'users/edit_profile', to: 'users#update_profile'
  root 'home#index'
  get 'home/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
