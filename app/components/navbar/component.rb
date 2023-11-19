# frozen_string_literal: true

# Views component for rendering the navigation bar.
class Navbar::Component < ApplicationComponent
  include TeamHelper

  def initialize(current_user:)
    @current_user = current_user

    super
  end

  private

  attr_reader :current_user

  def unread_notifications
    current_user.notifications.unread.count
  end

  def unread_notifications?
    unread_notifications.positive?
  end
end
