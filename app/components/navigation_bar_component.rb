# frozen_string_literal: true

# Views component for rendering the navigation bar.
class NavigationBarComponent < ApplicationComponent
  def initialize(current_user:)
    @current_user = current_user

    super
  end

  private

  attr_reader :current_user
end
