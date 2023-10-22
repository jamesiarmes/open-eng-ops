# frozen_string_literal: true

# Views component for rendering the sidebar menu.
class SidebarComponent < ApplicationComponent
  renders_many :items, Sidebar::ItemComponent

  def initialize(current_user:)
    @current_user = current_user

    super
  end

  private

  attr_reader :current_user
end
