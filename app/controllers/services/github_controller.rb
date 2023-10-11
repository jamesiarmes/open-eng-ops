class Services::GithubController < ServicesController
  before_action :set_service, except: %i[new create]
  before_action :pagination_params, only: %i[show collaborators members repos team team_children team_members teams]

  def auth; end

  def collaborators
    authorize @service, :show?

    @collaborators = @service.org_collaborators(
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
  end

  def members
    authorize @service, :show?

    @members = @service.org_members(
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
  end

  def repos
    authorize @service, :show?

    @repos = @service.repos(
      sort: params[:sort] || 'name',
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
  end

  def repo
    authorize @service, :show?
    add_breadcrumb(@service.name, services_github_path(@service))
    add_breadcrumb(params[:repo], services_github_repo_path(@service, repo: params[:repo]))

    @repo = @service.repo(params[:repo])
    @health = @service.repo_health(params[:repo])
  end

  def team
    authorize @service, :show?
    add_breadcrumb(@service.name, services_github_path(@service))

    @team = @service.team(params[:team])
    add_breadcrumb(@team.name, services_github_team_path(@service, team: params[:team]))

    @children = @service.child_teams(params[:team], page: params[:page] || 1,
                                     per_page: params[:per_page] || 10)
    @members = @service.team_members(params[:team], page: params[:page] || 1,
                                     per_page: params[:per_page] || 10)
  end

  def team_children
    authorize @service, :show?

    @children = @service.child_teams(params[:team], page: params[:page] || 1,
                                     per_page: params[:per_page] || 10)
  end

  def team_members
    authorize @service, :show?

    @members = @service.team_members(params[:team], page: params[:page] || 1,
                                     per_page: params[:per_page] || 10)
  end

  def teams
    authorize @service, :show?

    @teams = @service.teams(
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
  end

  private

  def set_service
    params[:id] ||= params[:github_id]

    super
  end
end
