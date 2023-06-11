# frozen_string_literal: true

require 'github_api'

module Services
  class Github < Service
    def to_partial_path
      'services/github'
    end

    def service_type
      'GitHub'
    end

    def org
      return nil unless config[:type] == 'org'

      @org ||= client.orgs.get(org_name: config[:org])
    end

    def user
      return nil unless config[:type] == 'user'

      @user ||= client.users.get(user: config[:user])
    end

    def owner
      @owner ||= org || user
    end

    def owner_param
      { config[:type].to_sym => config[config[:type].to_sym] }
    end

    def repo(name)
      # client.repos.get(repo: name, user: config[:org])
      client.repos.get(**repo_request_params(name))
    end

    def repo_health(name)
      return nil if repo(name).fork

      client.repos.community.profile(**repo_request_params(name))
    end

    def contributors(repo)
      client.repos.stats.contributors(**repo_request_params(repo))
    end

    def commit_activity(repo)
      client.repos.stats.commit_activity(**repo_request_params(repo))
    end

    def code_frequency(repo)
      client.repos.stats.code_frequency(**repo_request_params(repo))
    end

    def repo_request_params(repo)
      { repo:, user: config[config[:type].to_sym] }
    end

    def repos(direction: 'asc', page: 1, per_page: 10, sort: 'name')
      client.repos.list(direction:, page:, per_page:, sort:)
    end

    def client
      @client ||= ::Github.new do |c|
        c.user = config[:user] if config[:type] == 'user'
        c.org = config[:org] if config[:type] == 'org'
        c.access_token = config[:token]
      end
    end
  end
end
