# frozen_string_literal: true

class Services::GoogleWorkspaceController < ServicesController
  before_action :set_service, only: %i[show edit update destroy groups users]
  before_action :pagination_params, only: %i[groups users]

  def auth; end

  def groups
    @groups = @service.groups(page: params[:page])
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
