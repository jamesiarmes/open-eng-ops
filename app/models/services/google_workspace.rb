require 'google/api_client/client_secrets'

class Services::GoogleWorkspace < Service
  def self.table_name_prefix
    'services_google_workspace_'
  end

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

  def groups(page: nil, per_page: 10)
    response = client.list_groups(customer: 'my_customer',
                                  max_results: per_page, page_token: page)

    {
      data: response&.groups || [],
      page_info: {
        next_page: response&.next_page_token || nil
      }
    }
  end

  def group(id)
    idclient.get_group("groups/#{id}")
  end

  def group_members(id, page: nil, per_page: 10)
    response = idclient.list_group_memberships("groups/#{id}", page_token: page,
                                               page_size: per_page, view: 'FULL')

    {
      data: response&.memberships || [],
      page_info: {
        next_page: response&.next_page_token || nil
      }
    }
  end

  def add_group_member(group_id, user)
    membership = Google::Apis::CloudidentityV1::Membership.new
    membership.roles = [Google::Apis::CloudidentityV1::MembershipRole.new(name: 'MEMBER')]
    membership.preferred_member_key = Google::Apis::CloudidentityV1::EntityKey.new(id: user.email)

    idclient.create_group_membership("groups/#{group_id}", membership)
  rescue Google::Apis::ClientError => e
    # 409 is a conflict, which means the user is already a member of the group.
    raise e unless e.status_code == 409
  end

  def remove_group_member(group_id, user)
    membership = lookup_group_membership(group_id, user)
    return unless membership

    idclient.delete_group_membership(membership.name)
  end

  def lookup_group_membership(group_id, user)
    idclient.lookup_group_membership("groups/#{group_id}", member_key_id: user.email)
  end

  def users
    response = client.list_users(customer: 'my_customer')

    {
      data: response&.users || [],
      page_info: {
        next_page: response&.next_page_token || nil
      }
    }
  end

  def user(id)
    client.get_user(id)
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

  def idclient
    return @idclient if @idclient

    creds = Google::APIClient::ClientSecrets.new(client_credentials)
    @idclient = Google::Apis::CloudidentityV1::CloudIdentityService.new
    @idclient.authorization = creds.to_authorization
    @idclient.authorization.refresh!

    @idclient
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
