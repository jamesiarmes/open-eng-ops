# frozen_string_literal: true

Rails.application.routes.draw do
  get 'service/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :services, param: :id do
    member do
      get 'repo/:repo', action: :repo, as: :github_repo
      get 'repo/:repo/code-frequency', action: :repo_code_frequency, as: :github_repo_code_frequency
      get 'repo/:repo/commit-activity', action: :repo_commit_activity, as: :github_repo_commit_activity
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
