class ServicesController < ApplicationController
  before_action :set_service,
                only: %i[show edit update destroy repo repo_code_frequency
                         repo_commit_activity]

  def index
    # authorize! :index, :data_sets
    @services = Service.all
  end

  def show
    # authorize! :create, :data_sets

    # Move this to a GitHub specific controller.
    @repos = @service.repos(
      sort: params[:sort] || 'name',
      page: params[:page] || 1,
      per_page: params[:per_page] || 50
    )
    @pagination_params = pagination_params

    # add_breadcrumb('Create a new dataset', nil)
  end

  def new
    # authorize! :create, :data_sets
    @service = Service.new
    # add_breadcrumb('Create a new dataset', nil)
  end

  def create
    # authorize! :create, :data_sets
    @service = Service.new(service_params)

    if @service.save
      redirect_to services_path(@service), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # authorize! :update, :data_sets
    if @service.update(service_params)
      redirect_to service_path(@service), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def repo
    @repo = @service.repo(params[:repo])
    @health = @service.repo_health(params[:repo])
    # @contributors = @service.contributors(params[:repo])
  end

  def repo_code_frequency
    @code_frequency = @service.code_frequency(params[:repo])

    render json: [
      {
        name: 'Additions',
        color: '#acea99',
        library: { fill: 'origin' },
        data: @code_frequency.map do |week|
          { Time.at(week[0]).to_fs(:date) => week[1] }
        end.reduce({}, :merge)
      },
      {
        name: 'Deletions',
        color: '#fa908d',
        library: { fill: 'origin' },
        data: @code_frequency.map do |week|
          { Time.at(week[0]).to_fs(:date) => week[2] }
        end.reduce({}, :merge)
      }
    ]
  end

  def repo_commit_activity
    data = @service.commit_activity(params[:repo]).map do |activity|
      { Time.at(activity.week).to_formatted_s(:date) => activity.total }
    end

    render json: data.reduce({}, :merge)
  end

  private

  # Only allow a list of trusted parameters through.
  def service_params
    params.require(:service).permit(
      :name, :type, config: {}
    )
  end

  def pagination_params
    params.permit(:direction, :page, :per_page, :sort)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find_by_id(params[:id])
  end
end
