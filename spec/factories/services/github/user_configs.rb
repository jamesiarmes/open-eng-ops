# frozen_string_literal: true

FactoryBot.define do
  factory :services_github_user_config, class: 'Services::Github::UserConfig' do
    user

    username { Faker::Internet.username }
  end
end
