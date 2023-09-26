class Services::GithubController < ServicesController
  before_action :set_service, only: %i[show edit update destroy repo repos teams]

  def repos
    authorize @service, :show?

    @repos = @service.repos(
      sort: params[:sort] || 'name',
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
    @pagination_params = pagination_params
  end

  def repo
    authorize @service, :show?
    add_breadcrumb(@service.name, services_github_path(@service))
    add_breadcrumb(params[:repo], services_github_repo_path(@service, repo: params[:repo]))

    @repo = @service.repo(params[:repo])
    @health = @service.repo_health(params[:repo])
  end

  def teams
    authorize @service, :show?

    @teams = @service.teams(
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
    @pagination_params = pagination_params
  end

  private

  def set_service
    params[:id] ||= params[:github_id]

    super
  end
end
