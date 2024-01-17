# frozen_string_literal: true

class Services::GoogleWorkspaceController < ServicesController
  before_action :set_service, except: %i[new index create]
  before_action :pagination_params, only: %i[groups users]

  def auth; end

  def groups
    @groups = @service.groups(page: params[:page])
  end

  def group
    authorize @service, :show?
    add_breadcrumb(@service.name, services_google_workspace_path(@service))

    @group = @service.google_group(params[:group])
    add_breadcrumb(@group.display_name,
                   services_google_workspace_group_path(@service, group: params[:group]))
  end

  def group_members
    @members = @service.group_members(params[:group])
  end

  def users
    @users = @service.users
  end

  private

  def set_service
    params[:id] ||= params[:google_workspace_id]

    super
  end
end
