class ServicesController < ApplicationController
  include ServiceHelper

  before_action :authenticate_user!
  before_action :set_service,
                only: %i[show edit update destroy repo repos teams]
  before_action :set_types, only: %i[new edit]
  before_action :set_breadcrumbs

  def index
    authorize :service
    @services = Service.all
  end

  def show
    authorize @service
    add_breadcrumb(@service.name)
  end

  def new
    authorize :service
    @service = Service.new
  end

  def edit
    authorize @service
    add_breadcrumb(@service.name, service_path(@service))
    add_breadcrumb('Modify', edit_service_path(@service))
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

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to service_path(@service), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def service_config
    authorize :service, :new?
    @service = Service.new(type: params[:type])
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
    @pagination_params = params.permit(:after, :before, :direction, :page,
                                       :per_page, :sort)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find_by_id(params[:id])
  end

  def set_types
    @types = service_type_options
  end

  def set_breadcrumbs
    add_breadcrumb('Services', services_path)
  end
end
