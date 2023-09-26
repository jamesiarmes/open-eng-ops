# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :admin do
    resources :users
    resources :roles
    resources :teams
  end

  get 'service/index'
  resources :services, only: %i[index edit new]
  namespace :services do
    resources :github, param: :id do
      get 'repos'
      get 'teams'
      get 'repos/:repo', action: :repo, as: 'repo'
    end
  end

  # Defines the root path route ("/")
  root "services#index"
end
