class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service,
                only: %i[show edit update destroy repo repos teams]
  before_action :set_breadcrumbs

  def index
    authorize :service
    @services = Service.all
  end

  def teams
    authorize @service, :show?

    @teams = @service.teams(
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
    @pagination_params = pagination_params
  end

  def repos
    authorize @service, :show?

    @repos = @service.repos(
      sort: params[:sort] || 'name',
      page: params[:page] || 1,
      per_page: params[:per_page] || 10
    )
    @pagination_params = pagination_params
  end

  def show
    authorize @service
    add_breadcrumb(@service.name)
  end

  def new
    authorize :service
    @service = Service.new
  end

  def create
    authorize :service
    @service = Service.new(service_params)

    if @service.save
      redirect_to services_path(@service), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @service
    add_breadcrumb(@service.name, service_path(@service))
    add_breadcrumb('Modify', edit_service_path(@service))
  end

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to service_path(@service), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def repo
    authorize @service, :show?
    add_breadcrumb(@service.name, service_path(@service))
    add_breadcrumb(params[:repo], github_repo_service_path(@service, repo: params[:repo]))

    @repo = @service.repo(params[:repo])
    @health = @service.repo_health(params[:repo])
  end

  private

  # Only allow a list of trusted parameters through.
  def service_params
    params.require(:service).permit(
      :name, :id, :type, config: {}
    )
  end

  def get_params
    params.permit(:id)
  end

  def pagination_params
    params.permit(:after, :before, :direction, :page, :per_page, :sort)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find_by_id(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb('Services', services_path)
  end
end
