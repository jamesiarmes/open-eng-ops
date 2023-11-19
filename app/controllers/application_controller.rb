# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_default_breadcrumbs
  before_action :set_config
  before_action :all_services
  before_action :notification_read

  private

  def all_services
    @all_services ||= Service.all
  end

  def add_breadcrumb(name, path = nil)
    @breadcrumbs ||= []
    @breadcrumbs << { name:, path: }
  end

  def set_default_breadcrumbs
    return if %w[registrations sessions].include?(controller_name)

    @default_breadcrumbs = [{
                              name: controller_name.humanize,
                              path: request.path
                            }]
  end

  def set_config
    @config = Rails.application.config&.engops ||= {}
  end

  def notification_read
    return if params[:notification].blank?

    notification = current_user.notifications.find(params[:notification])
    notification.mark_as_read!
  end

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_to root_path unless turbo_frame_request?
  end

  def turbo_visit(url, frame: nil, action: nil)
    options = {frame: frame, action: action}.compact
    turbo_stream.append_all("head") do
      helpers.javascript_tag(<<~SCRIPT.strip, nonce: true, data: {turbo_cache: false})
        window.Turbo.visit("#{helpers.escape_javascript(url)}", #{options.to_json})
        document.currentScript.remove()
      SCRIPT
    end
  end
end
