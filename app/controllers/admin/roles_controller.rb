class Admin::RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: %i[show edit update destroy]
  before_action :set_breadcrumbs

  # GET /roles or /roles.json
  def index
    authorize :role
    @roles = Role.all
  end

  # GET /roles/1 or /roles/1.json
  def show
    authorize @role
    add_breadcrumb(@role.human_name)
  end

  # GET /roles/new
  def new
    authorize :role
    @role = Role.new
    @user = current_user
  end

  # GET /roles/1/edit
  def edit
    authorize @role
    add_breadcrumb(@role.human_name, admin_role_path(@role))
    add_breadcrumb('Modify', edit_admin_role_path(@role))
  end

  # POST /roles or /roles.json
  def create
    authorize :role
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_role_path(@role), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    authorize @role
    if @role.update(role_params)
      redirect_to admin_role_path(@role), notice: 'role was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    authorize @role

    if @role.name == 'admin'
      redirect_to admin_role_path(@role), status: :forbidden, alert: t('.admin')
    else
      @role.destroy
      redirect_to admin_roles_path, notice: t('.success')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:name, :description, :human_name,
                                 permission_ids_input: [])
  end

  def set_breadcrumbs
    add_breadcrumb('Roles', admin_roles_path)
  end
end
