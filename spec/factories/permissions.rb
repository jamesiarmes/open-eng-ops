# frozen_string_literal: true

FactoryBot.define do
  factory :permission do
    name { "#{Faker::Adjective.rand}_#{Faker::Emotion.rand}".downcase }
    controller { 'users' }
    controller_method { 'view' }
    description { Faker::Lorem.sentence }
  end
end
