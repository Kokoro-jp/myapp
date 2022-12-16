Rails.application.routes.draw do
  
  get 'posts/index'
  get 'stores/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :stores, controllers: {
    sessions: 'stores/sessions',
    passwords: 'stores/passwords',
    registrations: 'stores/registrations'
  }

  get 'users/home'
  get 'stores/home'
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  get 'stores/:id/profile', to: 'stores#show', as: 'store_profile'

  resources :users, only: [:show]
  resources :stores, only: [:show]
  resources :posts

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
