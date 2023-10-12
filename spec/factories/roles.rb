FactoryBot.define do
  factory :role do
    permissions { create_list(:permission, 3) }

    human_name { Faker::Book.genre }
    description { Faker::Lorem.paragraph }
  end
end
