# frozen_string_literal: true

# Notifications for multiple resource types.
class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true
end
