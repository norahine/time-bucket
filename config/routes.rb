Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :activities, only: [:index, :create, :edit, :update, :destroy]

  resources :entries, only: [:create, :edit, :update, :destroy]
  get 'reports', to: 'entries#index'
  get 'tracking', to: 'entries#new'

  get 'main/about'
  get 'main/faq'

  resources :contacts, only: [:new, :create]

  devise_scope :user do
    authenticated :user do
      root 'entries#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
