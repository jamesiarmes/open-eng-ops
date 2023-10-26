# frozen_string_literal: true

class Admin::Teams::GoogleWorkspace::GroupsController < ApplicationController
  POLICY_CLASS = Services::GoogleWorkspace::TeamGroupConfigPolicy

  before_action :ensure_frame_response
  before_action :set_relation, only: [:destroy]
  before_action :set_team, only: [:index]

  def index
    authorize :team_group_configs, policy_class: POLICY_CLASS
    @relations = @team.services_google_workspace_team_group_configs
  end

  def new
    authorize :team_group_configs, policy_class: POLICY_CLASS
    @relation = Services::GoogleWorkspace::TeamGroupConfig.new(team_id: params[:team_id])
  end

  def create
    authorize :team_group_configs, policy_class: POLICY_CLASS
    @relation = Services::GoogleWorkspace::TeamGroupConfig.new(relation_params)

    if @relation.save
      render turbo_stream: turbo_visit(
        admin_team_google_workspace_groups_path(team_id: @relation.team_id),
        frame: 'team-google-workspace-groups'
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @relation

    @relation.destroy
    redirect_to admin_team_google_workspace_groups_path(team_id: @relation.team_id), notice: t('.success')
  end

  private

  # Only allow a list of trusted parameters through.
  def relation_params
    params.require(:services_google_workspace_team_group_config).permit(
      :group_id, :id, :service_id, :team_id
    )
  end

  def set_relation
    @relation = Services::GoogleWorkspace::TeamGroupConfig.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
