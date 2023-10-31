class Services::Github::UserConfig < ApplicationRecord
  belongs_to :user

  before_save :set_github_user_id

  # Use a temporary username attribute that can be set to lookup the id.
  attribute :username, :string
  validates :username, 'Services::Github::Username': true

  def self.table_name
    'services_github_user_configs'
  end

  def profile_url
    "https://github.com/#{username}"
  end

  def username
    return attributes['username'] unless attributes['username'].nil?

    github_user.login if github_user_id.present?
  end

  private

  def github_user
    @github_user ||= Services::Github.first.user(github_user_id)
  end

  def set_github_user_id
    if username.present?
      self.github_user_id = Services::Github.first.user(github_user_id).id
    elsif !username.nil?
      self.github_user_id = nil
    end
  end
end
