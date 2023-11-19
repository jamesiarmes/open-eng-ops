# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { nil }
    type { "" }
    params { "" }
    read_at { "2023-11-16 22:17:09" }
  end
end
