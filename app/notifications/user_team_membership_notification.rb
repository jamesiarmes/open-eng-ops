# frozen_string_literal: true

# Notifications for a user's team membership.
#
# To deliver this notification:
#
# UserTeamMembershipNotification.with(post: @post).deliver_later(current_user)
# UserTeamMembershipNotification.with(post: @post).deliver(current_user)
class UserTeamMembershipNotification < Noticed::Base
  include TeamHelper

  deliver_by :database

  param :team
  param :state

  def message
    case params[:state]
    when :added
      "You've been <em>added</em> to <strong>#{team_name}</strong>.".html_safe
      # t('.added')
    when :removed
      "You've been <em>removed</em> from <strong>#{team_name}</strong>.".html_safe
      # t('.removed')
    else
      "Your membership in <strong>#{team_name}</strong> has been <em>updated</em>.".html_safe
      # t('.updated')
    end
  end

  def date
    record.created_at
  end

  def type
    case params[:state]
    when :added
      :success
    when :removed
      :warning
    else
      :info
    end
  end

  def url
    return admin_teams_path(notification: record.id) if params[:state] == :removed

    # TODO: Change this to the non-admin team page.
    admin_team_path(params[:team], notification: record.id)
  end

  def avatar
    Avatar::Component.new(
      src: params[:team].logo, name: params[:team].human_name,
      default: default_team_icon, disabled: params[:state] == :removed
    )
  end

  def team_name
    params[:team].human_name
  end
end
