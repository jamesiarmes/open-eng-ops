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
    resources :teams, param: :id do
      namespace :github, module: 'teams/github' do
        resources :teams
      end
    end
  end

  get 'service/index'
  resources :services, only: %i[index edit new create]
  namespace :services do
    resources :github, param: :id do
      get 'repos'
      get 'repos/:repo', action: :repo, as: 'repo'
      get 'teams'
      get 'teams/:team', action: :team, as: 'team'
      get 'teams/:team/children', action: :team_children, as: 'team_children'
      get 'teams/:team/members', action: :team_members, as: 'team_members'
    end
  end

  resources :user, param: :id

  # Defines the root path route ("/")
  root "services#index"
end
