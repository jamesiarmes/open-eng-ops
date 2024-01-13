# frozen_string_literal: true

class User::NotificationsController < ApplicationController
  def index
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.notifications.find(params[:id]).destroy

    redirect_to user_notifications_path
  end
end
