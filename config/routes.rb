Rails.application.routes.draw do
  root 'top#index'
  get 'posts/index'
  get 'stores/show'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  devise_for :stores, controllers: {
    sessions: 'stores/sessions',
    passwords: 'stores/passwords',
    registrations: 'stores/registrations'
  }
  devise_scope :store do
    post 'stores/guest_sign_in', to: 'stores/sessions#guest_sign_in'
  end

  get 'users/home'
  get 'stores/home'
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  get 'stores/:id/profile', to: 'stores#show', as: 'store_profile'

  resources :users, only: %i[show destroy] do
    get :favorites, on: :collection
  end
  resources :stores, only: %i[show destroy]
  resources :posts do
    collection do
      get 'search'
    end
  end

  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
end
