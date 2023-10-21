# frozen_string_literal: true

# Base class for views components.
class ApplicationComponent < ViewComponent::Base
  private

  def config
    @config ||= Rails.application.config&.engops ||= {}
  end
end
