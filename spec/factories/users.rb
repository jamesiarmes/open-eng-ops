# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::FunnyName.name }
    pronouns { 'they/them' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { 5.minutes.ago }

    trait :with_team do
      teams { create_list(:team, 1) }
    end
  end
end
