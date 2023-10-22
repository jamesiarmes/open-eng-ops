# frozen_string_literal: true

# Views component for rendering the navigation bar.
class Navbar::Component < ApplicationComponent
  def initialize(current_user:)
    @current_user = current_user

    super
  end

  private

  attr_reader :current_user
end
