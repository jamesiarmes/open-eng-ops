# frozen_string_literal: true

class Services::GoogleWorkspace::Users::InvitationsController < Admin::Users::InvitationsController
  include ServiceHelper

  before_action :authenticate_user!, except: [:new]
  before_action :set_service, only: %i[new create]
  before_action :set_google_user, only: %i[new create]

  def new
    authorize :user
    @user = User.new
    @user.name = @google_user.name.full_name
    @user.email = @google_user.primary_email
  end

  def create
    super do |user|
      break if user.errors.present? || @google_user.thumbnail_photo_url.blank?

      user.avatar.attach(
        io: URI.parse(@google_user.thumbnail_photo_url).open,
        filename: File.basename(@google_user.thumbnail_photo_url)
      )
    end
  end

  private

  def after_create_path_for(_resource)
    service_path(@service)
  end

  def set_google_user
    @google_user = set_service.user(params[:user_google_id])
  end

  def set_service
    @service ||= Service.find(params[:id] || params[:google_workspace_id])
  end
end
