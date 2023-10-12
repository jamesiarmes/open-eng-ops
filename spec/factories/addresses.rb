# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street1 { Faker::Address.street_address }
    locality { Faker::Address.city }
    administrative_area { Faker::Address.state_abbr }
    postal_code { Faker::Address.postcode[0..5] }
  end
end
