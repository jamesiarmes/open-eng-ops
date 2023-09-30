class Admin::Teams::Github::TeamsController < ApplicationController
  POLICY_CLASS = Services::Github::TeamToTeamPolicy

  before_action :ensure_frame_response
  before_action :set_relation, only: [:destroy]
  before_action :set_team, only: [:index]

  def index
    authorize :team_to_teams, policy_class: POLICY_CLASS

    @relations = @team.services_github_team_to_teams
  end

  def new
    authorize :team_to_teams, policy_class: POLICY_CLASS
    @relation = Services::Github::TeamToTeam.new(team_id: params[:team_id])
  end

  def create
    authorize :team_to_teams, policy_class: POLICY_CLASS
    @relation = Services::Github::TeamToTeam.new(relation_params)

    if @relation.save
      redirect_to admin_team_github_teams_path(team_id: @relation.team_id), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @relation

    @relation.destroy
    redirect_to admin_team_github_teams_path(team_id: @relation.team_id), notice: t('.success')
  end

  private

  # Only allow a list of trusted parameters through.
  def relation_params
    params.require(:services_github_team_to_team).permit(
      :github_team_id, :id, :service_id, :team_id
    )
  end

  def set_relation
    @relation = Services::Github::TeamToTeam.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
