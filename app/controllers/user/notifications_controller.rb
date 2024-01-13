# frozen_string_literal: true

class User::NotificationsController < ApplicationController
  before_action :set_notification, only: %i[destroy update]

  def index
    @user = current_user
  end

  def update
    if @notification.update(notification_params)
      redirect_to user_notifications_path
    else
      redirect_to user_notifications_path, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy

    redirect_to user_notifications_path
  end

  private

  # Only allow a list of trusted parameters through.
  def notification_params
    permitted = params.permit(
      :id, :read_at
    )

    permitted[:read_at] = Time.current if permitted[:read_at] == 'now'
    permitted
  end

  def set_notification
    @user = current_user
    @notification = @user.notifications.find(params[:id])
  end
end
