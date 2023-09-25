# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_default_breadcrumbs
  before_action :set_config

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
end
