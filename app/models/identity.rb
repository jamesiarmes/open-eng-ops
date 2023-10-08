# frozen_string_literal: true

# Authenticated identities for users and services.
class Identity < ApplicationRecord
  encrypts :token
  encrypts :refresh_token

  belongs_to :user
  belongs_to :service, optional: true

  validates :uid, presence: true
  validates :provider, presence: true
end
