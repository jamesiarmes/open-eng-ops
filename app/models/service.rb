# frozen_string_literal: true

# Base model for services.
class Service < ApplicationRecord
  serialize :config, ::JsonbSerializers

  has_one :identity, dependent: :destroy

  def service_type
    self.class.name.split('::').last
  end

  def route_helper_prefix
    'service'
  end

  def to_partial_path
    return self.class.partial_path if defined?(self.class.partial_path)

    super
  end

  # The title for this service.
  def service_title
    name
  end

  # The subtitle for this service.
  def service_subtitle
    nil
  end

  def service_avatar(size: :sm)
    "<i class=\"fa-solid fa-cloud fa-fw default-avatar-#{size}\" " \
    "title=\"#{service_type}\"></i>".html_safe
  end

  def identified?
    identity.present?
  end
end

