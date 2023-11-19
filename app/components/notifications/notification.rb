# frozen_string_literal: true

# Views component for rendering a single notification.
class Notifications::Notification < ApplicationComponent
  def initialize(notification:)
    @notification = notification

    super
  end

  private

  attr_reader :notification
end
