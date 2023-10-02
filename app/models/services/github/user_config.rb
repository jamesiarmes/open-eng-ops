class Services::Github::UserConfig < ApplicationRecord
  belongs_to :user

  def self.table_name
    'services_github_user_configs'
  end

  def profile_url
    "https://github.com/#{username}"
  end
end
