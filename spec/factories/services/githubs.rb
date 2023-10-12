# frozen_string_literal: true

FactoryBot.define do
  factory :services_github, class: 'Services::Github' do
    name { Faker::Company.name }
    type { 'Services::Github' }
    config { { org: Faker::Company.name.gsub(/[^\w-]/, '') } }
  end
end
