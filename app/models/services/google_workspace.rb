# require 'googleauth'
require 'google/api_client/client_secrets'

class Services::GoogleWorkspace < Service
  def self.service_type
    'Google Workspace'
  end

  def self.partial_path
    'google_workspace'
  end

  def route_helper_prefix
    'services_google_workspace'
  end

  def service_avatar_classes
    'fab fa-google'
  end

  def customer
    @customer ||= client.get_customer('my_customer')
  end

  def groups(page: nil, per_page: 1)
    response = client.list_groups(customer: 'my_customer',
                                  max_results: per_page, page_token: page)

    {
      data: response&.groups || [],
      page_info: {
        next_page: response&.next_page_token || nil
      }
    }
  end

  def users
    {
      data: client.list_users(customer: 'my_customer')&.users || []
    }
  end

  private

  def client
    return @client if @client

    creds = Google::APIClient::ClientSecrets.new(client_credentials)
    @client = Google::Apis::AdminDirectoryV1::DirectoryService.new
    @client.authorization = creds.to_authorization
    @client.authorization.refresh!

    @client
  end

  def client_credentials
    {
      web: {
        access_token: identity.token,
        refresh_token: identity.refresh_token,
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      }
    }
  end
end
