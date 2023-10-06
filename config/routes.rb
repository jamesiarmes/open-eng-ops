# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }, skip: [:sessions, :invitations]

  as :user do
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    get 'admin/users/invitations', to: 'admin/users/invitations#new'
    post 'admin/users/invitations', to: 'admin/users/invitations#create'
    get 'user/invitation/:id/accept', to: 'admin/users/invitations#edit', as: :user_invitation_accept
    patch 'user/invitation/:id', to: 'admin/users/invitations#update', as: :user_invitation
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
  resources :services, only: %i[index edit new create] do
    get 'config', action: :service_config, on: :new
  end

  namespace :services do
    resources :github, param: :id do
      get 'repos'
      get 'repos/:repo', action: :repo, as: 'repo'
      get 'teams'
      get 'teams/:team', action: :team, as: 'team'
      get 'teams/:team/children', action: :team_children, as: 'team_children'
      get 'teams/:team/members', action: :team_members, as: 'team_members'
    end

    resources :sample
  end

  resources :user, param: :id

  # Defines the root path route ("/")
  root "services#index"
end
