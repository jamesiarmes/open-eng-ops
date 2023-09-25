# frozen_string_literal: true

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

      @org ||= client.organization(config[:org])
    end

    def user
      return nil unless config[:type] == 'user'

      @use ||= client.user(config[:user])
    end

    def owner
      @owner ||= org || user
    end

    def owner_param
      { config[:type].to_sym => config[config[:type].to_sym] }
    end

    def repo(name)
      client.repo({
                    owner: config[:type] == 'org' ? config[:org] : config[:user],
                    repo: name
                  })
    end

    def repo_health(name)
      return nil if repo(name).fork

      client.community_profile({
                                 owner: config[:type] == 'org' ? config[:org] : config[:user],
                                 repo: name
                               })
    end

    def repos(direction: 'asc', page: 1, per_page: 10, sort: 'name')
      {
        data: if config[:type] == 'org'
                client.org_repos(config[:org], direction:, page:, per_page:, sort:)
              else
                client.repositories(user: config[:user], direction:, page:, per_page:, sort:)
              end,
        page_info:
      }
    end

    def teams(page: 1, per_page: 10)
      return { data: [], page_info: {} } unless config[:type] == 'org'

      {
        data: client.org_teams(config[:org], page:, per_page:),
        page_info:
      }
    end

    private

    def client
      @client ||= Octokit::Client.new(access_token: config[:token])
    end

    def page_info
      if client.last_response.rels[:next]
        rel = :next
        op = :-
      else
        rel = :prev
        op = :+
      end

      info = Rack::Utils.parse_query(URI(
        client.last_response.rels[rel].href
      ).query).symbolize_keys
      info[:page] = info[:page].to_i.send(op, 1)

      info[:total] = if client.last_response.rels[:last]
                       Rack::Utils.parse_query(URI(
                         client.last_response.rels[:last].href
                       ).query)['page'].to_i
                     else
                       info[:page]
                     end

      info
    end
  end
end
