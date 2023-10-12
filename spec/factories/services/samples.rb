# frozen_string_literal: true

FactoryBot.define do
  factory :services_sample, class: 'Services::Sample' do
    name { Faker::Color.color_name }
    type { 'Services::Sample' }
  end
end
