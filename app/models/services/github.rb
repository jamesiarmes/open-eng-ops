# frozen_string_literal: true

class Services::Github < Service
  has_many :services_github_team_configs, class_name: 'Services::Github::TeamConfig',
                                          dependent: :destroy, foreign_key: :service_id

  def self.table_name_prefix
    'services_github_'
  end

  def self.service_type
    'GitHub'
  end

  def self.partial_path
    'github'
  end

  def route_helper_prefix
    'services_github'
  end

  def service_avatar(size: :sm)
    "<i class=\"fa-brands fa-github fa-fw default-avatar-#{size}\" " \
    "title=\"#{service_type}\"></i>".html_safe
  end

  def service_subtitle
    config[:org]
  end

  def org
    @org ||= client.organization(config[:org])
  end
  alias :owner :org

  def repo(name)
    client.repo({
                  owner: config[:org],
                  repo: name
                })
  end

  def repo_health(name)
    return nil if repo(name).fork

    client.community_profile({
                               owner: config[:org],
                               repo: name
                             })
  end

  def repos(direction: 'asc', page: 1, per_page: 10, sort: 'name')
    {
      data: client.org_repos(config[:org], direction:, page:, per_page:, sort:),
      page_info:
    }
  end

  def teams(page: 1, per_page: 10)
    {
      data: client.org_teams(config[:org], page:, per_page:),
      page_info:
    }
  end

  def team(id)
    client.team(id)
  end

  def child_teams(id, page: 1, per_page: 10)
    {
      data: client.child_teams(id, page:, per_page:),
      page_info:
    }
  end

  def team_members(id, page: 1, per_page: 10)
    {
      data: client.team_members(id, page:, per_page:),
      page_info:
    }
  end

  def team_member?(team_id, username)
    client.team_member?(team_id, username)
  end

  def add_team_member(team_id, username)
    client.add_team_membership(team_id, username)
  end

  def remove_team_member(team_id, username)
    client.remove_team_membership(team_id, username)
  end

  def organization_member?(username)
    client.organization_member?(config[:org], username)
  end

  def update_organization_membership(username, role: :member)
    client.update_organization_membership(config[:org], user: username, role:)
  end

  def client
    @client ||= Octokit::Client.new(access_token: auth_token)
  end

  def auth_type
    config[:auth_type]
  end

  private

  def auth_token
    auth_type == 'oauth' ? identity.token : config[:token]
  end

  def page_info
    if client.last_response.rels[:next]
      info = page_rel_parsed(:next)
      info[:page] = info[:page].to_i - 1
    elsif client.last_response.rels[:prev]
      info = page_rel_parsed(:prev)
      info[:page] = info[:page].to_i + 1
    else
      info = { page: 1 }
    end

    info[:total] = page_total_pages(info)
    info
  end

  def page_rel_parsed(rel)
    Rack::Utils.parse_query(URI(
                              client.last_response.rels[rel].href
                            ).query).symbolize_keys
  end

  def page_total_pages(info)
    if client.last_response.rels[:last]
      page_rel_parsed(:last)[:page].to_i
    else
      info[:page] || 1
    end
  end
end
