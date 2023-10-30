# frozen_string_literal: true

class Services::GoogleWorkspace::UserConfig < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :google_user_id, presence: true

  def self.table_name
    'services_google_workspace_user_configs'
  end

  def email
    google_user.primary_email
  end

  def google_user
    @google_user ||= service.user(google_user_id)
  end
end
