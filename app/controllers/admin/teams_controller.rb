class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[show edit update destroy]
  before_action :set_breadcrumbs

  # GET /admin/teams
  def index
    authorize :team
    @teams = Team.all
  end

  # GET /admin/teams/1
  def show
    authorize @team
    add_breadcrumb(@team.human_name)
  end

  # GET /admin/teams/new
  def new
    authorize :team
    @team = Team.new
  end

  # POST /admin/teams
  def create
    authorize :team
    @team = Team.new(team_params)
    if @team.save
      redirect_to admin_team_path(@team), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/teams/1/edit
  def edit
    authorize @team
    add_breadcrumb(@team.human_name, admin_team_path(@team))
    add_breadcrumb('Modify', edit_admin_team_path(@team))
  end

  # PATCH/PUT /admin/teams/1
  def update
    authorize @team
    if @team.update(team_params)
      redirect_to admin_team_path(@team), notice: t('.success')
    else
      # TODO: Determine if there's a better way to do this.
      @team.errors.each do |e|
        e.instance_variable_set(:@attribute, :human_name) if e.attribute == :name
      end

      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/teams/1
  def destroy
    authorize @team

    @team.destroy
    redirect_to admin_teams_path, notice: t('.success')
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.require(:team).permit(:name, :description, :human_name, :logo, users: [], user_ids: [])
  end

  def set_breadcrumbs
    add_breadcrumb('Teams', admin_teams_path)
  end
end
