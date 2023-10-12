# frozen_string_literal: true

FactoryBot.define do
  factory :services_github_team_config, class: 'Services::Github::TeamConfig' do
    team
    service factory: :services_github

    github_team_id { Faker::Number.number(digits: 4) }
  end
end
