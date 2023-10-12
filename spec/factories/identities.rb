# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    user

    provider { 'github' }
    uid { Faker::Number.number(digits: 3) }
    token { Faker::Internet.device_token }
    refresh_token { Faker::Internet.device_token }
  end
end
