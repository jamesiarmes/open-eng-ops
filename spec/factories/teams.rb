# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    human_name { Faker::Movie.title }
    description { Faker::Lorem.paragraph }
  end
end
