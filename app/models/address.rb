class Address < ApplicationRecord
  # TODO: Support more than just US addresses.
  attribute :country, default: 'US'

  validates :country, presence: true, length: { is: 2 }
  validates :administrative_area, presence: true, length: { is: 2 }
  validates :locality, presence: true
  validates :postal_code, presence: true, length: { is: 5 }, format: { with: /\A\d{5}\z/ }
  validates :street1, presence: true

  has_one :user

  def combined_locality
    "#{locality}, #{administrative_area}"
  end
end
