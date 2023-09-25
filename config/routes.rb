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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :services, param: :id do
    member do
      get 'repos', action: :repos, as: :github_repos
      get 'teams', action: :teams, as: :github_teams
      get 'repo/:repo', action: :repo, as: :github_repo
    end
  end

  # Defines the root path route ("/")
  root "services#index"
end
